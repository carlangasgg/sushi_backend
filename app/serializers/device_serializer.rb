class DeviceSerializer
  include JSONAPI::Serializer
  attributes :name, :status, :local_id

  attribute :type do |object|
    object.class.name
  end
end
