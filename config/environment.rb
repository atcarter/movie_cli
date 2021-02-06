require 'pry'
require 'bundler'
require 'net/http'
require 'open-uri'
require 'json'
require 'dotenv'
Bundler.require
Dotenv.load("./.env")

require_all 'lib'