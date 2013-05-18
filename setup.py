from setuptools import setup

setup(
    name='procbot',
    description='Process Based Chatbot',
    version='0.1-dev',
    author='Jake Basile',
    scripts=[
        'procbot.py',
    ],
    install_requires=[
        'pyyaml>=3.0,<4.0',
    ],
    include_package_data=True,
)
