namespace :release_conductor do
  namespace :deploy do
    task :finished do
      if fetch(:unfuddle_user).nil? || fetch(:unfuddle_password).nil?
        puts "You must set environment variables UNFUDDLE_USER and UNFUDDLE_PASSWORD to use the release conductor"
      else
        case fetch(:stage).to_s
        when 'beta-staging' then ReleaseConductor.punch_tickets(:staging,self,['beta'],'beta-dev')
        when 'staging' then ReleaseConductor.punch_tickets(:staging,self,[nil,'code'],'code-dev')
        when 'production' then ReleaseConductor.punch_tickets(:production, self,[nil,'code'],'code')
        when 'beta-production' then ReleaseConductor.punch_tickets(:production, self,['beta'],'beta')
        else
          puts "Unknown stage #{fetch(:stage)}, not punching any tickets"
          # ReleaseConductor.testing(self)
        end
      end
    end
    task :testing do
      ReleaseConductor.punch_tickets_to_testing(self,[nil,'code'],'code')
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
