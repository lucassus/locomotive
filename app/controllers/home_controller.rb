class HomeController < ApplicationController
  def index
  end

  def dummy_error
    raise "I'm only testing exception notification"
  end
end
