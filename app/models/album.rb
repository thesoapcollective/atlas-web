class Album < ActiveRecord::Base
  before_save :clean_attributes

  validates :title, length: { minimum: 0, maximum: 255 }

  belongs_to :user
  has_many :photos, dependent: :destroy

  private

  def clean_attributes
    if self.description.present?
      self.description.strip!
      self.description.downcase!
    end
    if self.title.present?
      self.title.strip!
      self.title.downcase!
    end
  end
end
