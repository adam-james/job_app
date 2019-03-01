class Chore < ApplicationRecord
  validates :run_at, presence: true
end
