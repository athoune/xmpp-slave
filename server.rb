#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'

JID = ENV['JABBER_JID'] || 'username@jabber.org'
PASSWORD = ENV['JABBER_PASS'] || 'password'
MUC = ENV['JABBER_MUC'] || 'machin@conference.jabber.org'

require 'slave'

http :talk do |msg|
  $muc.say msg
end

combo :ping do
  "Pong"
end

combo :dump do |data|
  puts data
  "moi je dis #{data}"
end

xmpp :rldp do |qui, quoi|
  "#{qui} est un #{quoi}"
end

xmpp :add do |a, b|
  a.to_i + b.to_i
end