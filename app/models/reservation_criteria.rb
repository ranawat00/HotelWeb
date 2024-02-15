class ReservationCriteria < ApplicationRecord
  belong_to :property
  validates :time_period, presence: true,format: { with: /\A[a-zA-Z]+\z/,
                                    message: 'It should be a word, try with daily, weekly or monthly' }
  validates :others_fee,presence:true, numericality:{greter_than_or_equal_to:1}
  validates :rate,presence:true, numericality:{greter_than_or_equal_to:1}
  validates :min_time_period,presence:true, numericality:{greter_than_or_equal_to:1}
  validates :max_guest,presence:true, numericality:{only_integer:true,greter_than_or_equal_to:1}

end
