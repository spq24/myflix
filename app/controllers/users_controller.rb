class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
  before_filter :require_admin, only: [:index]
  before_filter :correct_user, only: [:edit, :update, :account]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @result = UserSignup.new(@user).sign_up(params[:stripeToken], params[:invitation_token])

    if @result.successful?
      flash[:success] = "Thank you for signing up with MyFlix."
      session[:user_id] = @user.id
      redirect_to home_path
    else
      flash[:danger] = @result.error_message
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "You have successfully edited Your Account"
      redirect_to edit_user_path
    else
      flash[:danger] = "Something Went Wrong! Your account wasn't edited properly"
      render :edit
    end 
  end

    def account
      @user = User.find(params[:id])
      stripe_customer = Stripe::Customer.retrieve("#{@user.customer_token}").to_json
      parsed_sc = ActiveSupport::JSON.decode(stripe_customer)
      @plan = parsed_sc["subscriptions"]["data"][0]["plan"]["name"]
      next_bill_date = parsed_sc["subscriptions"]["data"][0]["current_period_end"]
      @bill_date = Time.at(next_bill_date).strftime('%m/%d/%Y')
      plan_cost = parsed_sc["subscriptions"]["data"][0]["plan"]["amount"].to_f / 100
      @cost = ActionController::Base.helpers.number_to_currency(plan_cost)


      stripe_invoices = Stripe::Invoice.all(customer: "#{@user.customer_token}", limit: 8).to_json
      parsed_si = ActiveSupport::JSON.decode(stripe_invoices)
      @invoices = parsed_si
      @billed = ActionController::Base.helpers.number_to_currency(parsed_si["data"][0]["lines"]["data"][0]["amount"].to_f / 100)
      @billed_date = Time.at(parsed_si["data"][0]["date"]).strftime('%m/%d/%Y')
      @period_start = Time.at(parsed_si["data"][0]["lines"]["data"][0]["period"]["start"]).strftime('%m/%d/%Y')
      @period_end = Time.at(parsed_si["data"][0]["lines"]["data"][0]["period"]["end"]).strftime('%m/%d/%Y')
  end

  def show
    @user = User.find(params[:id])
  end

  def new_with_invitation_token
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipient_email)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  def index
    @users = User.all
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted."
    redirect_to videos_path
  end

  def make_admin
    @user = User.find(params[:id])
    @user.update_column(:admin, true)
    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :admin)
  end

  def handle_invitation
      if params[:invitation_token].present?
        invitation = Invitation.where(token: invitation_token).first
        @user.follow(invitation.inviter)
        invitation.inviter.follow(@user)
        invitation.update_column(:token, nil)
     end
  end

  def require_admin
    if !current_user.admin?
      flash[:danger] = "You are not authorized to do that."
      redirect_to home_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to home_path unless current_user == @user
  end
end