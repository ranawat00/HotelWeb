class Ability
  include Cancan: :Ability
    def  initializer(user)
    user ||= User.def new 
      if user.admin?
      can :manage, :all
      can :manage, :user
      else 
        can :create,User,id:user.id
        can :show,User,id:user.id
        can :update,User,id:user.id
        can :destroy,User,id:user.id
        
    end
  end
end