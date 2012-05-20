class StaticPagesController < ApplicationController
  def show
    @static_page = StaticPage.find_by_name!(params[:id])
  end
end
