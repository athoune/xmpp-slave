require 'xmpp4r'
require 'xmpp4r/muc'
require 'json'

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

def xmpp(name, format = :plain, &block)
  $slave ||= Class.new
  $slave.class.send(:define_method, "slave_#{name}", &block)
end

def http(name, format = :plain, &block)
  get "/#{name}" do
    q = params[:q]
    if (format == :json || params[:f] == 'json') && q!= nil
      q = JSON.parse(q)
    end
    response = case block.arity
      when 0: block.call
      when 1: block.call(q)
      else block.call(*q)
    end
    return response if format == :plain
    return response.to_json
  end
end

def combo(name, format = :plain, &block)
  xmpp name, format, &block
  http name, format, &block
end