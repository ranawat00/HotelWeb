class Reversation < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :guests,presence:true

  validate :check_guest_capaicty
  validate :end_date_after_start_date
  validate :start_date_smaller_then_today
  validate :property_available_on_reservation_dates

  before_save :set_reservation_price

private  

def set_reservation_price
  num_nights=end_date-start_date
  self.price=(property.reservation_price_rate*num_nights)+property.reservation_criteria.others_fee
end 


def check_guest_capaicty
  property=property.find_by(id: property_id)
  return unless property && guest >property.reservation_criteria_max_guest
  errors.add(:max_guest ,'Guests number exceeded the maximum allowed guest')
end

def end_date_after_start_date
  return if end_date.blank? || start_date.blank?
  return unless end_date<= start_date
  errors.add(:end_date,"End date must be after start date")
end

def  start_date_smaller_then_today
  return if start_date.blank?
  return unless start_date<date.today
  error.add(:start_date,'Start date must be greater than today')
end 

def property_available_on_reservation_dates
  return unless start_date.present?||end_date.present?
  overlapping_reservations = Reservation.where(property_id:)
  where('(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?)',
             start_date, start_date, end_date, end_date)
      .where.not(id:)

    errors.add(:base, 'Property is already reserved for the selected dates') if overlapping_reservations.exists?
end

end
