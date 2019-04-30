class UserHasRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  accepts_nested_attributes_for :role

#  validates_uniqueness_of :role_id, scope: :user_id
#  validates_presence_of :role_id, :user_id
end

# == Schema Information
#
# Table name: user_has_roles
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  role_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
