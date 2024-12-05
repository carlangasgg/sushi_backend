class Device::DeviceController < ApplicationController
  def show_pos
    @pos = Pos.all
    render json: @pos
  end

  def show_pos_job
    data = Rails.cache.read("cached_pos_data")
    Rails.logger.info("Data retrieved from cache: #{data.inspect}")
  
    if data
      render json: data
    else
      render json: { error: "No cached data available" }, status: :not_found
    end
  end

  def show_printers
    @printers = Printer.all
    render json: @printers
  end

  def show_red_systems
    @rs = RedSystem.all
    render json: @rs
  end

  def show_locales
    @locales = Local.all
    render json: @locales
  end
end