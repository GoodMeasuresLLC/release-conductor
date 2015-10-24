require 'release-conductor/version'
require 'net/https'
require 'json'

load File.expand_path("../release-conductor/tasks/release-conductor.rake", __FILE__)

module ReleaseConductor

  def self.unfuddle_request(config,url,type)
    uri = URI("https://#{config.fetch(:account)}.unfuddle.com#{url}")

    request = case
    when type == :get
      Net::HTTP::Get
    when type == :put
      Net::HTTP::Put
    else
      raise "Add support for #{type}"
    end.new(uri)

    request.content_type='application/xml'
    request.basic_auth config.fetch(:unfuddle_user),config.fetch(:unfuddle_password)

    yield(request) if block_given?

    Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true, :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
      http.request(request)
    end
  end

  def self.get(config,url)
    response = unfuddle_request(config, url + ".json", :get) do |request|
      request.content_type='application/json'
    end

     unless response.is_a?(Net::HTTPSuccess)
      raise "failure for #{url}, got #{response.code} #{response.message}"
     end

     JSON.parse(response.body)
  end

  def self.put(config, url, body)
    response = unfuddle_request(config, url, :put) do |request|
      request.body = body
    end

    unless response.is_a?(Net::HTTPSuccess)
      puts "response.body=#{response.body}"
      raise "failure for #{uri}, got #{response.code} #{response.message}"
    end
    response.body
  end

  def self.run_ticket_report(config, report_id)
    hash=get(config, "/api/v1/projects/#{config.fetch(:project_id)}/ticket_reports/#{report_id}/generate")
    (hash["groups"].first||{})["tickets"]
  end

  def self.version_ids(versions)
    versions.map do |version|
      case version
      when nil then nil
      when 'code' then 3
      when 'beta' then 2
      else
        raise 'bad version ' + version
      end
    end
  end

  def self.filter_by_versions(tickets,versions)
    version_ids = self.version_ids(versions)
    tickets.select do |ticket|
      version_ids.include?(ticket["version_id"])
    end
  end

  def self.set_phase(config, tickets, phase_value_id)
    tickets.each do |ticket|
      url = "/api/v1/projects/#{config.fetch(:project_id)}/tickets/#{ticket['id']}"

      # puts "Fetching Ticket Details from #{url}"
      ticket_details = get(config, url)

      xml = %Q{
        <ticket>
          <field2-value-id>#{phase_value_id}</field2-value-id>
          <summary>testing</summary>
        </ticket>
      }
      put(config,url,xml)
    end
  end

  def self.report(config,env)
    case env
    when :staging then config.fetch(:fixed_tickets_in_development_report_id)
    when :production then config.fetch(:verified_tickets_in_staging_report_id)
    end
  end


  def self.punch_tickets(env,config,versions)
    tickets = filter_by_versions(run_ticket_report(config,report(config,env)),versions)
    phase_id = config.fetch(env == :staging ? :test_phase : :production_phase)
    set_phase(config, tickets, phase_id)
  end

  def self.testing(config)
    ReleaseConductor.punch_tickets(:production, config,['beta'])
    # puts filter_by_versions(
      # run_ticket_report(config, config.fetch(:verified_tickets_in_staging_report_id)),['beta'])
  end

end

