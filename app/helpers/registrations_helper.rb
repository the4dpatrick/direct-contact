module RegistrationsHelper
  def checked_plan?(user, plan)
    user.plan ? current_plan?(plan) : false
  end

  def current_plan?(plan)
    plan.id == current_user.plan.id
  end
end
