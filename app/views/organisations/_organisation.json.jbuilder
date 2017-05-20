json.extract! organisation, :id, :user_id, :name, :service_type, :description, :address, :postcode, :city, :country, :telephone, :created_at, :updated_at
json.url organisation_url(organisation, format: :json)
