require 'kaminari'
require 'devise'
require 'cancan'
require 'acts_as_list'
require 'attribute_normalizer'
require 'friendly_id'
require 'addressable/uri'
require 'sunspot_rails'
require 'resque'
require 'settingslogic'
require 'nested_form'
require 'protected_attributes'
require 'rails-observers'

module EnjuCore
  class Engine < ::Rails::Engine
  end
end
