class ApplicationController < ActionController::Base
  def protect_against_forgery?
    false
  end
end
