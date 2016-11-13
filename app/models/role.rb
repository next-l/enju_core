class Role < ActiveRecord::Base
  include MasterModel
  validates :name, presence: true, format: { with: /\A[A-Za-z][a-z_,]*[a-z]\z/ }
  has_many :user_has_roles
  has_many :users, through: :user_has_roles
  after_save :clear_all_cache
  after_destroy :clear_all_cache

  extend FriendlyId
  friendly_id :name

  def localized_name
    display_name.localize
  end

  def self.all_cache
    if Rails.env == 'production'
      Rails.cache.fetch('role_all') { Role.select(:name).all }
    else
      Role.select(:name)
    end
  end

  def clear_all_cache
    Rails.cache.delete('role_all')
  end

  def self.default_role
    Role.where(name: 'Guest').first
  end

  private

  def valid_name?
    true
  end
end

# == Schema Information
#
# Table name: roles
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  display_name :string
#  note         :text
#  created_at   :datetime
#  updated_at   :datetime
#  score        :integer          default(0), not null
#  position     :integer
#
