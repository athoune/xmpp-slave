XMPPSlave
=========

XMPPSlave is a dummy slave wich listen XMPP and HTTP. It works as Sinatra does.

You declare action like this :
    
    slave :dump do |what|
        "What do you mean by #{what}?"
    end

And in your chatroom, *dump* is now a key word :
    
    you : dump plop
    bot : What do you mean by plop?
