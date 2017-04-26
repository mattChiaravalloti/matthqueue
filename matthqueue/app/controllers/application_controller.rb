class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method def logged_in?
    !session[:account_id].nil?
  end

  helper_method def current_account
    Account.find(session[:account_id])
  end

  helper_method def admin_logged_in?
    !session[:institution_id].nil?
  end

  helper_method def current_institution
    Institution.find(session[:institution_id])
  end
end
