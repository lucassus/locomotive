Rails.application.config.middleware.use OmniAuth::Builder do
  ## Twitter integration
  twitter_config = Settings.omniauth.twitter
  provider :twitter, twitter_config.app_id, twitter_config.app_secret

  ## Facebook integration
  facebook_config = Settings.omniauth.facebook
  provider :facebook, facebook_config.app_id, facebook_config.app_secret,
    :scope =>  'publish_stream,offline_access',
    :client_options => { :ssl => { :ca_path => '/etc/ssl/certs'} }
end
