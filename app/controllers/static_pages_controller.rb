class StaticPagesController < ApplicationController
  # Renders a static page
  def show
    @static_page = StaticPage.find_by_name!(params[:id])
  end
end
