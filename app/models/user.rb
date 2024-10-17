class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :role, inclusion: %w[admin, user], allow_nil: true

  def self.available_roles
    %w[user admin]
  end
end
