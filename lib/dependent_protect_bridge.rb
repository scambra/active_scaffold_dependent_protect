module DependentProtectSecurity
  def authorized_for_destroy?
    self.class.reflect_on_all_associations.all? do |association|
      association.options[:dependent] != :protect || self.send(association.name).blank?
    end
  end
end
ActiveRecord::Base.class_eval { include DependentProtectSecurity }