class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :albums, dependent: :destroy
  has_many :photos

  before_validation :clean_attributes

  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }

  private

  def clean_attributes
    if self.email.present?
      self.email.strip!
      self.email.downcase!
    end
  end
end
