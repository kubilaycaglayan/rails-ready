class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_statuses, -> { order(created_at: :desc) },
           dependent: :destroy

  validates :role, inclusion: %w[admin, user], allow_nil: true

  def self.available_roles
    %w[user admin]
  end

  def is_admin?
    role == "admin"
  end
end
