# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

local = Local.find_or_create_by!(name: "Local principal", status: 0)

User.find_or_create_by!(name: "Usuario de prueba", local_id: local.id)

device = Device.create!(name: "Dispositivo principal", status: 'active', local_id: local.id)

pos = device.poses.create!(name: "POS principal", status: 'active', local_id: local.id)
printer = device.printers.create!(name: "Impresora Principal", status: 'active', local_id: local.id)
red_system = device.red_systems.create!(name: "Sistema principal", status: 'active', local_id: local.id)
