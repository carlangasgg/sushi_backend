class FetchPosJob
  include Sidekiq::Job

  sidekiq_options retry: 5  # Retry 5 times before giving up

  def perform
    begin
      response = HTTParty.get("http://localhost:3000/device/show_pos")
      
      if response.success?
        data = JSON.parse(response.body)  # Parse the response
        Rails.logger.info("Data being cached: #{data.inspect}")
        Rails.cache.write("cached_pos_data", data, expires_in: 1.hour)
        Rails.logger.info("Cache after writing: #{Rails.cache.read("cached_pos_data").inspect}")
        Rails.logger.info("Successfully fetched and cached PoS data.")
      else
        Rails.logger.error("Failed to fetch data from the API: #{response.message}")
      end

    rescue => e
      Rails.logger.error("Error occurred while fetching PoS data: #{e.message}")
    end
  end
end
