class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
  before_filter :require_admin, only: [:index]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @result = UserSignup.new(@user).sign_up(params[:stripeToken], params[:invitation_token])

    if @result.successful?
      flash[:success] = "Thank you for registering with MyFlix. Please sign in now."
      redirect_to sign_in_path
    else
      flash[:danger] = @result.error_message
      render :new
    end
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
    params.require(:user).permit(:email, :password, :full_name, :admin)
  end

  def handle_invitation
      if params[:invitation_token].present?
        invitation = Invitation.where(token: invitation_token).first
        @user.follow(invitation.inviter)
        invitation.inviter.follow(@user)
        invitation.update_column(:token, nil)
     end
  end

    private

  def require_admin
    if !current_user.admin?
      flash[:danger] = "You are not authorized to do that."
      redirect_to home_path
    end
  end
end