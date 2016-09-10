class PhotosController < ApplicationController
  def create
    @photo = current_user.candidate.photos.build(photo_params)

    if @photo.save
      render json: @photo
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:content)
  end
end
