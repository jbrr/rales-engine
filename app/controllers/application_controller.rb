require "application_responder"

class ApplicationController < ActionController::Base
  helper_method :format_unit_price
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def format_unit_price
    if params[:unit_price]
      params["unit_price"] = BigDecimal.new(params["unit_price"]) * 100
    end
  end
end
