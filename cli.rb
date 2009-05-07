#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'json'

url = "http://localhost:4567/#{ARGV[0]}"
args = ARGV
args.shift
if args != nil && args.length > 0
  url += '?f=json&q=' + URI.escape(args.to_json)
end
Net::HTTP.get_print URI.parse(url)