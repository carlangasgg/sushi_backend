class FetchRedServicesJob
  include Sidekiq::Job

  sidekiq_options retry:

  def perform
    begin
      response = HTTParty.get("http://localhost:3000/device/show_red_services")
      
      if response.success?
        data = JSON.parse(response.body)
        Rails.cache.write("cached_red_services_data", data, expires_in: 1.hour)
        Rails.logger.info("Successfully fetched and cached Red services data.")
      else
        Rails.logger.error("Failed to fetch data from the API: #{response.message}")
      end

    rescue => e
      Rails.logger.error("Error occurred while fetching red services data: #{e.message}")
    end
  end
end
