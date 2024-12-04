require 'httparty'
require 'json'

class TestScript
  include HTTParty

  base_uri 'http://localhost:3000'

  def initialize
    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
  end

  def update_status(device_id, type, status)
    body = { 
      device: {
        id: device_id,
        type: type,
        status: status
      } 
    }.to_json

    response = self.class.patch("/admin/update_device_status", headers: @headers, body: body)
    
    if response.success?
      puts "Successfully updated Device #{device_id} to status #{status}: #{response.body}"
    else
      puts "Failed to update Device #{device_id}: #{response.body}"
    end
  end
end

simulator = TestScript.new

statuses = %w[active interrupted inactive]
types = %w[pos printer red_system]
device_id = 1 

loop do
  status = statuses.sample
  type = types.sample
  
  simulator.update_status(device_id, type, status)

  sleep 10
end