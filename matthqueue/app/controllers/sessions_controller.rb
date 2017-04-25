class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @account = Account.find_by(email: params[:email])
    if !@account.nil? && @account.password == params[:password]
      session[:account_id] = @account.id
      redirect_to @account
    else
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
