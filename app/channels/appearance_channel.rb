class AppearanceChannel < ApplicationCable::Channel
  before_subscribe :check_user
  before_unsubscribe :check_user

  def subscribed
    puts "🟢 subscribed #{current_user.id}"
    UserStatus.create(user: current_user, status: "online")
  end

  def unsubscribed
    puts "🔥 unsubscribed #{current_user.id}"
    UserStatus.create(user: current_user, status: "away")
    current_user = nil
  end

  def appear(data)
    UserStatus.create(user: current_user, status: "online")
    puts "appearRR 🟢 #{current_user.id}", data
  end

  def away
    UserStatus.create(user: current_user, status: "away")
    puts "away 🟡 #{current_user.id}"
  end

  private

  def check_user
    reject unless current_user
  end
end
