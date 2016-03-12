module Paperclip
  class Cropper < Thumbnail
    def initialize(file, options = {}, attachment = nil)
      super
      @current_geometry.width = 500
      @current_geometry.height = 500
    end

    def target
      @attachment.instance
    end

    # NOTE: Assumes photo's width > height.
    def transformation_command
      width = target.image_geometry(:original).width.to_i
      height = target.image_geometry(:original).height.to_i
      ratio = width / height
      target_height = 1000
      target_width = (target_height * ratio).to_i
      resize_command = ['-resize', "#{target_width}x#{target_height}"]
      crop_command = ['-crop', "#{@current_geometry.width}x#{@current_geometry.height}+#{target_width / 2 - @current_geometry.width / 2}+#{target_height / 2 - @current_geometry.height / 2}", '+repage']
      resize_command + crop_command + super
    end
  end
end
