task run: :environment do
  ApiKeyUpdateJob.perform_now
end
