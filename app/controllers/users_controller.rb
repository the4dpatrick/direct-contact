class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def show
  end

  def update
    plan = Plan.find(user_params[:plan]) unless user_params[:plan].nil?
    user_params = user_params.except(:plan)
    if @user.update(user_params)
      @user.update_plan(plan) unless plan.nil?
      redirect_to users_path, notice: 'User updated'
    else
      redirect_to users_path, alert: 'Unable to update user'
    end
  end

  def destroy
    if @user == current_user
      redirect_to users_path, notice: "Can't delete yourself"
    else
      @user.destroy
      redirect_to users_path, notice: 'User deleted.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :plan, :name, :password, :password_confirmation, :remember_me, :stripe_token, :coupon)
  end
end
