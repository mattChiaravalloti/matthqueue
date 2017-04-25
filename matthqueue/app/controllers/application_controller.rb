class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method def logged_in?
    !session[:account_id].nil?
  end

  helper_method def current_account
    Account.find(session[:account_id])
  end
end
