#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

require File.expand_path("../config/boot.rb", __FILE__)
require 'rack/connection_release'
require 'rack/log_exceptions'
require 'rack/serial_initializer'
require 'rack/transaction_tracer'
require 'sc_core/rack/filter'

Padrino.use ScCore::Rack::Filter
Padrino.use Rack::TransactionTracer
Padrino.use Rack::LogExceptions
Padrino.use Rack::SerialInitializer
Padrino.use RackMetrics::Rack
Padrino.use Rack::ConnectionRelease

run Padrino.application
