Procbot is a stupid bot that works with processes.

## Installation

Grab latest via Git for easy updating:

```bash
$ git clone https://github.com/jakebasile/procbot.git
```

then get it up and running:

```bash
$ cd procbot
$ pip3 install sleekxmpp # If you want XMPP. You probably do.
$ mkdir logs quotes # for the default log and quote scripts.
$ ./procbot.py
```

Later, you can move this to your own (maybe private?) repo in order to add your own scripts to it. An easy(ish) way of doing that is to add the main repo as remote upstream, and merge in changes as needed.

## Configuration

Here's a config for the most useless bot ever, an echobot.

```json
{
    "nick": "stupid-bot",
    "nick_reg": "(?:sb|stupid-bot)",
    "adapter": "simple",
    "scripts": {
        "echo": {
            "trigger": "^(.*)$",
            "command": [
                "echo",
                "{user} said {0}"
            ]
        }
    }
}
```

`nick` is the nickname the bot will use, while `nick_reg` is the regular expression it will use to figure out if it's being spoken to. You can insert the `nick_reg` in triggers by using "%NICK". `adapter` we'll see in a moment.

`trigger` is the regex that must be matched to activate that script. It can have capture groups. These capture groups are replaced in the `command` args along with the `user` who sent it and their `message`. Note that `command` is broken into individual arguments. This is because they are run through Python's `subprocess` module with `shell=False` for added "security".

You can also specify multiple triggers with by using `triggers`. If you use capture groups, you should probably always have the same number of them. Example:

```json
{
    ...
    "karma":
        "triggers": [
            "^\\+1 (.*)$", 
            "^(.*)\\+\\+$"
        ], 
}
    
```

You can also add a `transform` option. It works a lot like `sed`. This one makes everything more serious.

```json
{
    ...
    "transform": {
        "in": "^(.*)$",
        "out": "{0}",
    },
}
```

## Running

You can choose from two adapters. Simple or XMPP. I'll probably add an IRC adapter later. You can turn on extra logging with `-d` and specify a config file with `-c`. Logging goes to STDERR, so redirect it somewhere else if you don't want it.

### Simple

The dumb adapter. It reads from STDIN and prints to STDOUT.

Start it by adding this line to your config:

```json
"adapter": "simple",
```

It expects input in the format "$USER:$MESSAGE". 

```shell
$ procbot.py 2> /dev/null
moe:derp
moe said derp
```

EOF (Ctrl-D) to end.

### XMPP

To connect to XMPP, add something like this to your config file. You need to have [sleekxmpp][] installed for it to work.

```json
{
    "adapter": "xmpp",
    "xmpp": {
        "server": "chat.example.com",
        "port": 5222,
        "jid": "procbot@chat.example.com",
        "password": "supersecret",
        "full_name": "Proc Bot",
        "rooms": [
            "fun@conf.example.com",
            "notfun@conf.example.com"
        ],
    },
}
```

## Contribution

Want to add a script? Go for it!

1. Fork the repo!
2. Clone the repo!
3. Contribute!
4. Add name and url to CONTRIBUTORS.txt!
5. Pull Request!

## Why?

I was bored on a Friday night.


[PyYAML]: http://pyyaml.org/wiki/PyYAML
[sleekxmpp]: http://sleekxmpp.com
