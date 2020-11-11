class UserUploader < CarrierWave::Uploader::Base
  unless Rails.env.test?
    include Cloudinary::CarrierWave
  end

  def store_dir
    if Rails.env.test?
      "uploads_#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end
end
