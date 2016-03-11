class PhotosController < ApplicationController
  layout 'photo', only: [:show]

  before_action :load_album

  def create
    @photo = Photo.new(photo_params)
    @photo.album = @album
    @photo.user = current_user
    @photo.save
    redirect_to album_path(@album)
  end

  def new
    @photo = Photo.new
  end

  def show
    @photo = Photo.find_by(id: params[:id])
  end

  private

  def load_album
    unless @album = Album.find_by(id: params[:album_id])
      redirect_to root_path
    end
  end

  def photo_params
    params.require(:photo).permit(
      :description,
      :image,
      :title,
    )
  end

end
