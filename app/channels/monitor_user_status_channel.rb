class MonitorUserStatusChannel < ApplicationCable::Channel
  def subscribed
    unless current_user.is_admin?
      logger.info "🔴 unauthorized #{current_user.id}"
      reject
      return
    end

    logger.info "🟢 subscribed #{current_user.id}"

    stream_from "monitor_user_status_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
