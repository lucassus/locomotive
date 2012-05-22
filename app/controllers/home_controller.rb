class HomeController < ApplicationController
  add_breadcrumb I18n.t('links.home'), 'root_path'

  # Renders the Home Page
  def index
  end

  # Raises a dummy error for testing error notification solutions
  def dummy_error
    raise "I'm only testing exception notification" unless Rails.env.production?
  end
end
