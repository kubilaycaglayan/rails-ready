
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
    def find_verified_user
      return unless cookies.encrypted[:_rails_ready_session]["warden.user.user.key"]

      current_user_id ||= cookies.encrypted[:_rails_ready_session]["warden.user.user.key"][0][0]
      verified_user = User.find_by(id: current_user_id)

      if verified_user
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
