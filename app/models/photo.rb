class Photo < ActiveRecord::Base
  has_attached_file :image,
    styles: {
      highdef: 'x1080',
      thumbnail: { processors: [:cropper] },
    },
    convert_options: {
      highdef: '-quality 95',
      thumbnail: '-quality 60 -strip',
    }
    # TODO: Add a missing image.
    # default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image,
    content_type: /\Aimage\/.*\Z/,
    size: { in: 0..8.megabytes }

  before_validation :clean_attributes

  validates :title, length: { maximum: 255 }

  belongs_to :album
  belongs_to :user

  def image_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(Paperclip.io_adapters.for(self.image))
  end

  private

  def clean_attributes
    self.description.strip! if self.description.present?
    self.title.strip! if self.title.present?
  end
end
