XMPPSlave
=========

XMPPSlave is a dummy slave wich listen XMPP and HTTP. It works as Sinatra does.

You declare action like this :
    
    #XMPP only
    xmpp :ping
        "Pong"
    end

    #HTTP only
    http :hello
        "Hello world"
    end
    
    #XMPP and HTTP
    combo :dump do |what|
        "What do you mean by #{what}?"
    end


And in your chatroom, *dump* is now a key word :
    
    you : dump plop
    bot : What do you mean by plop?

In your shell :
    
    $ curl http://localhost:4567/dump?q=plop
    What do you mean by plop?

With the cli client :

    $ ./cli.rb dump plop
    What do you mean by plop?

Ingredients
-----------

 * [xmpp4r](http://home.gna.org/xmpp4r/)
 * [Sinatra](http://www.sinatrarb.com/)
