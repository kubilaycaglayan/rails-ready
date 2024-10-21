class AppearanceChannel < ApplicationCable::Channel
  before_subscribe :check_user
  before_unsubscribe :check_user

  def subscribed
    puts "🟢 subscribed #{current_user.id}"
    current_user.appear
  end

  def unsubscribed
    puts "🔥 unsubscribed #{current_user.id}"
    current_user.disappear
    current_user = nil
  end

  def appear(data)
    current_user.appear
    puts "appearRR 🟢 #{current_user.id}", data
  end

  def away
    current_user.away
    puts "away 🟡 #{current_user.id}"
  end

  private

  def check_user
    reject unless current_user
  end
end
