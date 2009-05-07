#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'xmpp4r'
require 'xmpp4r/muc'
require 'json'
require 'slave'

JID = ENV['JABBER_JID'] || 'username@jabber.org'
PASSWORD = ENV['JABBER_PASS'] || 'password'
MUC = ENV['JABBER_MUC'] || 'machin@conference.jabber.org'

configure do
  $client = Jabber::Client.new("#{JID}/slave-robot")
  $client.connect
  $client.auth(PASSWORD)
  $muc = Jabber::MUC::SimpleMUCClient.new($client)
  $muc.on_message { |time,nick,text|
      puts (time || Time.new).strftime('%I:%M') + " <#{nick}> #{text}"
      args = text.split(/\s+/)
      action = "slave_#{args[0]}"
      args.shift
      if $slave.methods.include? action
        puts "[Action] #{action}"
        puts "[Arguments] #{args.join(' ')}"
        resp = $slave.method(action)[*args]
        puts "[response] #{resp}"
        if resp != nil
          puts resp
          $muc.say "La réponse est : #{resp}"
        end
      end
    }
  muc_jid = Jabber::JID.new(MUC)
  muc_jid.resource= 'Beuha le robot'
  $muc.join(muc_jid)
end

get '/talk' do
  msg = params[:msg]
  $muc.say msg
  "Message a : #{msg}\n"
end

slave :dump do |data|
  puts data
  "moi je dis #{data}"
end

slave :rldp do |qui, quoi|
  "#{qui} est un #{quoi}"
end

slave :add do |a, b|
  a.to_i + b.to_i
end