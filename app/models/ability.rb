class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    can :manage, Campaign do |camp|
      camp.user == user
    end

    
  end
end
