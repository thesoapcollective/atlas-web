class Album < ActiveRecord::Base
  before_validation :clean_attributes,
                    :generate_id_hash

  validates :title, length: { maximum: 255 }
  validates :id_hash, presence: true, uniqueness: true, length: { maximum: 16 }

  belongs_to :user
  has_many :photos, dependent: :destroy

  private

  def generate_id_hash
    self.id_hash = SecureRandom.urlsafe_base64(8) if self.id_hash.blank?
  end

  def clean_attributes
    self.description.strip! if self.description.present?
    self.title.strip! if self.title.present?
  end
end
