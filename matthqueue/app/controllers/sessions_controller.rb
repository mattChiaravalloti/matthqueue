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

  def new_admin
    render :new_admin
  end

  def create_admin
    @institution = Institution.find_by(name: params[:name])
    if !@institution.nil? && @institution.password == params[:password]
      session[:institution_id] = @institution.id
      redirect_to @institution
    else
      redirect_to admin_login_path
    end
  end
end
