class Creative < ApplicationRecord
  has_and_belongs_to_many :placements

  validates :identifier, presence: true, uniqueness: true
end
