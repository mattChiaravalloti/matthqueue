class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  def show
  end

  # GET /accounts/new
  def new
    @institutions = Institution.all.map { |i| i.name }
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  def create
    institution = Institution.find_by(:name => params[:institution_name])

    if institution.nil?
      @account = Account.new
      @error = "No such institution #{params[:institution_name]}"
      render :new
    else
      secret = params[:institution_secret]
      params = account_params
      params[:institution_id] = institution.id
      params[:professor] = institution.secret == secret
      @account = Account.new(params)
      @account.password = params[:password_hash]

      if @account.save
        session[:account_id] = @account.id
        redirect_to @account, notice: 'Account was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.password == params[:old_password]
      @account.password = params[:new_password]
      if @account.save
        redirect_to @account, notice: 'Account was successfully updated.'
      else
        @error = @account.errors
        render :edit
      end
    else
      @error = 'Incorrect password'
      render :edit
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
    redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:name, :email, :password_hash, :professor, :institution_id)
    end
end
