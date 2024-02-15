class Image < ApplicationRecord
  belongs_to :properties
  validates :source, presence: true
end
