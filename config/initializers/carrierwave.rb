CarrierWave.configure do |config|
  fog_config = Settings.fog

  config.fog_credentials = {
    :provider               => fog_config.provider,
    :aws_access_key_id      => fog_config.access_key_id,
    :aws_secret_access_key  => fog_config.secret_access_key
  }

  config.fog_directory = fog_config.directory
end
