Rails.application.config.middleware.use OmniAuth::Builder do
  ## Twitter integration
  provider :twitter, Settings.twitter_app_id, Settings.twitter_app_secret

  ## Facebook integration
  provider :facebook, Settings.facebook_app_id, Settings.facebook_app_secret,
    :scope =>  'publish_stream,offline_access',
    :client_options => { :ssl => { :ca_path => '/etc/ssl/certs'} }
end
