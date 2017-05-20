class User < ApplicationRecord
  has_one :organisation

  devise :database_authenticatable, :registerable, :confirmable, 
        :recoverable, :rememberable, :trackable, :validatable
end
