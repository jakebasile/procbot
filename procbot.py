#!/usr/bin/env python3

# Copyright 2013 Jake Basile
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import re
import subprocess
import pprint
import logging
import sys

logging.basicConfig()
log = logging.getLogger(__name__)

class ProcBot(object):

    def __init__(self, config):
        log.debug('Processing configuration')
        nick = config.get('nick', 'procbot')
        nick_reg = config.get('nick_reg', '(pb|procbot)')
        log.debug('Using nick ' + nick)
        scripts = []
        for key in config['scripts']:
            log.debug('Processing configuration for ' + key)
            key_config = config['scripts'][key]
            proc_key_config = {}
            if 'trigger' not in key_config:
                log.error('No trigger in configuration for ' + key)
                continue
            if 'command' not in key_config:
                log.error('No command in configuration for ' + key)
                continue
            if 'help' not in key_config:
                log.warn('No help in configuration for ' + key)
            trigger = key_config['trigger'].replace(
                '%NICK', nick_reg
            )
            log.debug('{} trigger regex is {}'.format(key, trigger))
            proc_key_config = {
                'key': key,
                'trigger': re.compile(trigger, re.I),
                'command': key_config['command'],
                'help': key_config.get('help', ''),
            }
            if 'transform' in key_config:
                try:
                    proc_key_config['transform'] = (
                        re.compile(key_config['transform']['in'], re.I|re.M),
                        key_config['transform']['out']
                    )
                except KeyError:
                    log.error('Missing in or out transform on key ' + key)
                    continue
            scripts.append(proc_key_config)
            log.debug('Processed config for {}:\n{}'.format(
                key, pprint.pformat(proc_key_config))
            )
        self.scripts = scripts

    def run(self):
        log.info('ProcBot started')
        while True:
            try:
                inp = input()
            except InterruptedError:
                break
            except EOFError:
                break
            except KeyboardInterrupt:
                break
            user, message = inp.split(':')
            for res in self.proc(user, message):
                if res.strip() != '':
                    print(res)
        log.info('Procbot stopping')

    def proc(self, user, message):
        log.info('Received message "{}" from {}'.format(message, user))
        for script in self.scripts:
            match = script['trigger'].match(message)
            log.debug('Testing message against trigger for ' + script['key'])
            if match is not None:
                log.debug('Message matches trigger for ' + script['key'])
                log.debug('found groups for this trigger: ' + pprint.pformat(match.groups()))
                args = [arg.format(*match.groups(), user=user, message=message) for arg in script['command']]
                log.debug('Calling subprocess with args: ' + pprint.pformat(args))
                try:
                    results = subprocess.check_output(
                        args,
                        universal_newlines=True,
                        timeout=5,
                    )
                except subprocess.CalledProcessError:
                    log.error('Error from subprocess.')
                    yield 'Error!'
                    continue
                except subprocess.TimeoutExpired:
                    log.error('Subprocess timed out.')
                    yield 'Timeout!'
                    continue
                log.debug('Results from subprocess: ' + results)
                if 'transform' in script:
                    log.debug('Tranforming output')
                    in_re, out_fmt  = script['transform']
                    t_match = in_re.search(results)
                    if t_match is None:
                        log.debug('Transform had no matches!')
                        continue
                    log.debug('transform matches: ' + pprint.pformat(t_match.groups()))
                    yield out_fmt.format(*t_match.groups(), user=user, message=message)
                    continue
                if results.strip() != '':
                    yield results.strip()
        log.debug('Finished testing scripts.')

if __name__ == '__main__':
    import argparse
    try:
        import yaml
    except ImportError:
        log.warn('Unable to load PyYAML, defaulting to JSON')
        import json

    fmt = 'yaml' if 'yaml' in locals() else 'json'
    
    parser = argparse.ArgumentParser(
        description='Another stupid bot, this time with Subprocesses!'
    )
    parser.add_argument(
        '-c',
        '--config',
        type=argparse.FileType('r'),
        help='A configuration file to read. Default: ./procbot.' + fmt,
        default=None
    )
    parser.add_argument(
        '-d',
        '--debug',
        action='store_true',
        help='Enable debugging output.',
        default=False
    )
    args = parser.parse_args()
    log.level = logging.DEBUG if args.debug else logging.INFO
    log.info('ProcBot starting')
    if args.config == None:
        log.debug('Defaulting to ./procbot.{} for configuration'.format(fmt))
        args.config = open('procbot.{}'.format(fmt), 'r')
    if fmt == 'yaml':
        config = yaml.load(args.config)
    else:
        config = json.load(args.config)
    log.debug('Configuration loaded: \n' + pprint.pformat(config))
    args.config.close()
    bot = ProcBot(config)
    bot.run()

