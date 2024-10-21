class UserStatus < ApplicationRecord
  belongs_to :user

  validates :status, inclusion: { in: %w[online away], message: "%{value} is not a valid status" }

  after_create :stream_statuses

  def stream_statuses
    statuses = User.includes(:user_statuses).all.map do |user|
      user_status = user.user_statuses.first

      { user_id: user.id, status: user_status&.status_to_emoji }
    end

    ActionCable.server.broadcast "monitor_user_status_channel", { statuses: statuses }
  end

  def status_to_emoji
    case status
    when "online"
      "🟢"
    when "away"
      "🟡"
    else
      "◻️"
    end
  end
end
