Procbot is a stupid bot that works with processes.

## Installation

There really isn't any, to speak of.

    $ wget https://raw.github.com/jakebasile/procbot/master/procbot.py && chmod+x procbot.py

You should also install [PyYAML][] to make config files easier to read.

## Configuration

You can use YAML if you have it, but it will fall back to JSON. Here's a config for the most useless bot ever, an echobot.

    nick: stupid-bot
    nick_reg: (?:sb|stupid-bot)
    scripts:
        echo:
            trigger: ^(.*)$
            command:
                - echo
                - {user} said
                - "{0}"

`trigger` is the regex that must be matched to activate that script. It can have capture groups. These capture groups are replaced in the `command` args along with the `user` who sent it and their `message`. Note that `command` is broken into individual arguments. This is because they are run through Python's `subprocess` module with `shell=False` for added "security".

You can also add a `transform` option. This one makes everything more serious.

            transform:
                in: ^(.*)$
                out: "{0}!"

## Running

You can choose from two adapters. Simple or XMPP. I'll probably add an IRC adapter later.

### Simple

The dumb adapter. It reads from STDIN and prints to STDOUT. You can turn on extra logging with `-d` and specify a config file with `-c`. Logging goes to STDERR, so redirect it somewhere else if you don't want it.

Start it by adding this line to your config:

    adapter: simple

It expects input in the format "$USER:$MESSAGE". 

    $ procbot.py 2> /dev/null
    moe:derp
    moe said derp

EOF to end.

### XMPP

To connect to XMPP, add something like this to your config file. You need to have [sleekxmpp][] installed for it to work.

    adapter: xmpp
    xmpp:
        server: chat.example.com
        port: 5222
        jid: procbot@chat.example.com
        password: supersecretpassword
        full_name: Proc Bot
        rooms:
            - fun@conf.example.com
            - notfun@conf.example.com

## Why?

I was bored on a Friday night.

[PyYAML]: http://pyyaml.org/wiki/PyYAML
[sleekxmpp]: http://sleekxmpp.com
