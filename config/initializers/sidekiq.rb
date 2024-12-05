# config/initializers/sidekiq.rb

require 'sidekiq-cron'

# Configure Sidekiq to connect to Redis
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }

  # Register scheduled jobs from the config/schedule.yml file
  schedule_file = "config/schedule.yml"
  if File.exist?(schedule_file)
    # Load the cron job schedule from the YAML file
    schedule = YAML.load_file(schedule_file)
    schedule[:schedule].each do |job_name, job_details|
      # Ensure the cron jobs are correctly created
      Sidekiq::Cron::Job.create(job_details)
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end
