# encoding: utf-8

module ApplicationHelper

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

end
