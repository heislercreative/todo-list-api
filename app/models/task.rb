class Task < ApplicationRecord
  belongs_to :project

  validates :text, presence: true, length: { maximum: 60 }
end
