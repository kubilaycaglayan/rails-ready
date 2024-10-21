class UserStatus < ApplicationRecord
  belongs_to :user

  validates :status, inclusion: { in: %w[online offline away], message: "%{value} is not a valid status" }

  after_create :stream_statuses

  def stream_statuses
    statuses = User.all.map do |user|
      status = user.user_statuses.last&.status
      { user_id: user.id, status: }
    end

    ActionCable.server.broadcast "monitor_user_status_channel", { statuses: statuses }
  end
end
