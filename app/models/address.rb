class Address < ApplicationRecord
  belongs_to :property
  validates :city, presence: true,length: {maximum: 200}
  validates :state, presence: true,length: {maximum: 200}
  validates :street, presence: true,length: {maximum: 200}  
  validates :house_number, presence: true,length: {maximum: 200}
  validates :zip_code, presence: true,length: {maximum: 200}
  validates :country, presence: true,length: {maximum: 200}
end