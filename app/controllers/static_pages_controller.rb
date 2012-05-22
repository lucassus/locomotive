class StaticPagesController < ApplicationController
  add_breadcrumb I18n.t('links.home'), 'root_path'

  # Renders a static page
  def show
    @static_page = StaticPage.find_by_name!(params[:id])
    add_breadcrumb @static_page.name.titleize, static_page_path(@static_page)
  end
end
