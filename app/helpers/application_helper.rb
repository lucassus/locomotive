# encoding: utf-8

# General purpose helper methods
module ApplicationHelper

  # Renders div container with flash messages
  # Available flash message types:
  # * info (blue)
  # * notice (yellow)
  # * success (green)
  # * error (red)
  # @return [String] rendered <div class='flash'> container with flash messages or nil
  #   if there are no flash messages
  def flash_messages
    return if flash.empty?

    content_tag(:div, class: 'flash') do
      flash.collect do |type, message|
        content_tag(:div, :class => "alert alert-#{type}") do
          link_to('×', '#', class: 'close', :'data-dismiss' => 'alert') + content_tag(:p, message)
        end
      end.join("\n").html_safe
    end
  end

  # Renders a link for switching locale
  # @param [#to_sym] locale a new locale
  # @return [String] rendered link <a ...>locale</a>
  def switch_locale_link(locale)
    link_to locale, url_for(locale: I18n.default_locale != locale.to_sym ? locale.to_sym : nil)
  end

  # Converts given text to html using markdown
  # @param [String] text a text to convert
  # @return [String] html
  def markdown(text)
    BlueCloth.new(text).to_html
  end

end
