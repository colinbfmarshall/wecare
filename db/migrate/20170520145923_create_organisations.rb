class CreateOrganisations < ActiveRecord::Migration[5.0]
  def change
    create_table :organisations do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :service_type
      t.text :description
      t.string :email
      t.string :telephone
      t.string :website
      t.string :address
      t.string :postcode
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
