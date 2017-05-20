class Organisation < ApplicationRecord
  belongs_to :user

  validates :name, :service_type, :description, :address, :postcode, :telephone, presence: true

  geocoded_by :postcode
  after_validation :geocode
  after_validation :reverse_geocode

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.city = geo.city
      obj.country = geo.country_code
    end
  end

end
