module CanCanRules
  def can? action, resource
    @ability ||= User.current_ability || Ability.new(User.current_user)
    @ability.can? action, resource
  end
  
  def cannot? action, resource
    @ability ||= User.current_ability || Ability.new(User.current_user)
    @ability.cannot? action, resource
  end
end
