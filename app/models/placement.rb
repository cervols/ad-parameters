class Placement < ApplicationRecord
  has_and_belongs_to_many :creatives

  validates :identifier, presence: true, uniqueness: true
end
