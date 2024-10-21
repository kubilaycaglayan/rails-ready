class UserStatus < ApplicationRecord
  belongs_to :user
  validates :status, inclusion: { in: %w[online offline away], message: "%{value} is not a valid status" }
end
