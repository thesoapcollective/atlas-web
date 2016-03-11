class AlbumsController < ApplicationController
  before_action :load_album

  def show
  end

  private

  def load_album
    unless @album = Album.find_by(id: params[:id])
      redirect_to root_path
    end
  end
end
