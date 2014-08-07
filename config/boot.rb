# Defines our constants
SERVICE_NAME = "livolve"
PADRINO_ENV  = ENV["PADRINO_ENV"] ||= ENV["RACK_ENV"] ||= "development"  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
require 'restclient'
require 'action_dispatch'
require 'sc_core/add_timestamp_migrations_to_padrino'
require 'logger'
require 'sc_core/supply_chain'
Bundler.require(:default, PADRINO_ENV)
require 'sc_core/base_application'



Padrino.before_load do
end

##
# Add your after load hooks here
#
Padrino.after_load do
  Padrino.require_dependencies Padrino.root('app/helpers/*.rb')
  Padrino.require_dependencies Padrino.root('app/errors/*.rb')
end

Padrino.load!
