# encoding: utf-8

module ApplicationHelper

  # Possible flash messages types: info, notice, success, error (blue, yellow, green, red)
  def flash_messages
    return if flash.empty?

    content_tag(:div, :class => 'flash') do
      flash.collect do |type, message|
        content_tag(:div, :class => "alert alert-#{type}") do
          link_to('×', '#', :class => 'close', :'data-dismiss' => 'alert') + content_tag(:p, message)
        end
      end.join("\n").html_safe
    end
  end

  def switch_locale_link(locale)
    link_to locale, url_for(:locale => I18n.default_locale != locale.to_sym ? locale.to_sym : nil)
  end

end
