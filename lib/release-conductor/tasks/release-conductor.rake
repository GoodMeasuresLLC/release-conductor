namespace :release_conductor do
  namespace :deploy do
    task :finished do
      puts "fetch(:stage)=#{fetch(:stage)}"
      case fetch(:stage)
      when 'beta-staging' then ReleaseConductor.punch_tickets(:staging,self,['beta'])
      when 'staging' then ReleaseConductor.punch_tickets(:staging,self,[nil,'code'])
      when 'production' then ReleaseConductor.punch_tickets(:production, self,[nil,'code'])
      when 'beta-production' then ReleaseConductor.punch_tickets(:production, self,['beta'])
      else
        ReleaseConductor.testing(self)
      end
    end
    task :testing do
      ReleaseConductor.punch_tickets_to_testing(self,['beta'])
    end
  end
end

after 'deploy:finished', 'release_conductor:deploy:finished'

namespace :load do
  task :defaults do
    set :account, 'goodmeasures'
    set :unfuddle_user,       -> { ENV['UNFUDDLE_USER'] }
    set :unfuddle_password,       -> { ENV['UNFUDDLE_PASSWORD'] }
    set :project_id, 1
    set :fixed_tickets_in_development_report_id, 55
    set :verified_tickets_in_staging_report_id, 66
    # execute this curl to get the list of custom field values, and then get those numbers from
    # there
      # curl -i -u username:password -X 
      # GET -H 'Accept: application/xml' 
      # 'https://goodmeasures.unfuddle.com/api/v1/projects/1/custom_field_values.xml'
    set :test_phase, 10
    set :production_phase, 15
  end
end
