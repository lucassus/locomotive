class AvatarUploader < CarrierWave::Uploader::Base
  storage :fog

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
