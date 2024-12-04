class Admin::AdminController < ApplicationController
  before_action :set_device

  def check_device_status
    render json: PosSerializer.new(@device)
  end

  def update_device_status
    begin
      if @device.update(status: device_params[:status])
        render json: DeviceSerializer.new(@device)
      else
        render json: { errors: @device.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ArgumentError => e
      render json: format_enum_error(e), status: :unprocessable_entity
    end
  end

  private

  def set_device
    device_type = params[:device][:type]
    case device_type
    when 'pos'
      # binding.break
      @device = Pos.find(params[:device][:id])
    when 'printer'
      @device = Printer.find(params[:device][:id])
    when 'red_system'
      @device = RedSystem.find(params[:device][:id])
    else
      render json: { error: 'Device not found' }, status: :not_found
    end
	rescue ActiveRecord::RecordNotFound
    render json: { error: 'Device not found' }, status: :not_found
	end

  def device_params
		params.require(:device).permit(:name, :status, :local_id)
	end

  def format_enum_error(exception)
    {
      message: "Validation failed",
      details: exception.message,
      hint: "Please provide a valid status value. Allowed values are: #{Pos.statuses.keys.join(', ')}"
    }
  end
end
