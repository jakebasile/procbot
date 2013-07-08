from setuptools import setup

setup(
    name='procbot',
    description='Process Based Chatbot',
    version='0.1',
    author='Jake Basile',
    url='http://github.com/jakebasile/procbot',
    scripts=[
        'procbot.py',
    ],
    install_requires=[
        'pyyaml>=3.0,<4.0',
        'sleekxmpp>=1.1,<=2.0',
    ],
    include_package_data=True,
)
