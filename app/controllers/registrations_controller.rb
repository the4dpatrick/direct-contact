class RegistrationsController < Devise::RegistrationsController
  before_action :set_plan, only: :new
  before_action :set_plans, only: [:edit, :update]
  before_action :set_user, only: [:update_plan, :update_card, :cancel_plan]

  def new
    if @plan && Plan.where(name: @plan).present? && @plan != 'admin'
      super
    else
      redirect_to pricing_path, notice: 'Please select one of the plans below'
    end
  end

  def create
    @plan ||= session[:plan]
    cookies[:emails_found_count] = nil
    super
  end

  def update_plan
    if @user.update_plan(edit_params[:plan])
      redirect_to edit_user_registration_path, notice: 'Successfully updated plan'
    else
      flash[:error] = 'Unable to update plan'
      redirect_to edit_user_registration_path
    end
  end

  def update_card
    @user.stripe_token = edit_params[:stripe_token]
    if @user.save
      redirect_to edit_user_registration_path, notice: 'Successfully updated card'
    else
      flash[:error] = 'Unable to update card'
      redirect_to edit_user_registration_path
    end
  end

  def cancel_plan
    @user.cancel_subscription
    redirect_to edit_user_registration_path, notice: 'Plan successfully canceled'
  end

  protected

  def after_sign_up_path_for(resource)
    root_path(first_signin: true)
  end

  private

  def build_resource(*args)
    super
    if params[:plan]
      resource.plan_id = Plan.where(name: params[:plan]).first.id
    end
  end

  def set_plan
    session[:plan] = params[:plan]
    @plan = session[:plan]
  end

  def set_plans
    @plans = Plan.where('name != ?', 'admin')
  end

  def set_user
    @user = current_user
  end

  def edit_params
    params.require(:user).permit(:plan, :stripe_token)
  end
end
