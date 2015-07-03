class UsersController < Clearance::UsersController
  before_filter :require_login, only: [:edit, :update]
  before_filter :has_access, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    user_params = params.require(:user).permit(:first_name, :last_name)
    @user.update(user_params)
    flash.notice = "Updated"
    redirect_to @user
  end

  private

  def has_access
    if current_user.id != params[:id].to_i
      flash.alert = "Page not found"
      redirect_to root_path
    end
  end

  def permit_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

  def user_from_params
    user_params = params[:user] || Hash.new
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.first_name = first_name
      user.last_name = last_name
    end
  end
end
