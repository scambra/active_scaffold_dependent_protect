require 'rubygems'
require 'active_record'
require 'active_record/reflection'
require File.join(File.dirname(__FILE__), '..', 'lib', 'dependent_protect_bridge')

# Mocking everything necesary to test the plugin.
class Company
  def initialize(with_or_without)
    @with_companies = with_or_without == :with_companies
    @with_company = with_or_without == :with_company
    @with_main_company = with_or_without == :with_main_company
  end
  
  def self.class_name
    self.name
  end
  
  # not the real signature of the method, but forgive me
  def self.before_destroy(s=nil)
    @@before = s
  end
  
  include ActiveRecord::Reflection
  include DependentProtectSecurity
  
  def self.has_many(association_id, options = {})
    reflection = create_reflection(:has_many, association_id, options, self)
  end
  def self.has_one(association_id, options = {})
    reflection = create_reflection(:has_one, association_id, options, self)
  end
  def self.belongs_to(association_id, options = {})
    reflection = create_reflection(:belongs_to, association_id, options, self)
  end
  has_many :companies, :dependent => :protect
  has_one :company, :dependent => :protect
  belongs_to :main_company, :dependent => :protect, :class_name => 'Company'
  
  def companies
    if @with_companies
      [nil]
    else
      []
    end
  end
  
  def company
    @with_company
  end
  
  def main_company
    @with_main_company
  end
end
