# Defines our constants
SERVICE_NAME = "livolve"
PADRINO_ENV  = ENV["PADRINO_ENV"] ||= ENV["RACK_ENV"] ||= "development"  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
# require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
require 'restclient'
Bundler.require(:default, PADRINO_ENV)
require 'padrino'
require 'validates_timeliness'

Padrino.before_load do
  p "before load called"
end

##
# Add your after load hooks here
#
Padrino.after_load do
  p "after load called"
  Padrino.require_dependencies Padrino.root('app/helpers/*.rb')
  Padrino.require_dependencies Padrino.root('app/errors/*.rb')
end

Padrino.load!
