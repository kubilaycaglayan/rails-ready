
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      logger.info "🟢 -- connect"
      self.current_user = find_verified_user
    end

    def disconnect
      logger.info "🔴 -- disconnect"
      self.current_user = nil
    end


    private
    def find_verified_user
      if (user = env["warden"].user)
        User.find_by(id: user.id) || reject_unauthorized_connection
      else
        reject_unauthorized_connection
      end
    end
  end
end
