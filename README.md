`twitter`: The Cog Twitter Command Bundle
=========================================

# TL;DR

    !twitter:tweet "Currently experiencing long request times; our engineering team is investigating"

# Overview

The `twitter` bundle exposes a `tweet` command, which allows you to
tweet from Cog, using multiple Twitter accounts. Put it in an incident
response pipeline to tweet updates from your support account. Add it
to a release pipeline to tweet when a new version of your software is
available.

Using the `--as` option allows you to tweet from different Twitter
accounts. For details on how to set this up, please consult the
detailed documentation for the tweet command in `config.yaml'.

By default, execution of the `twitter:tweet` command will require the
`twitter:tweet` permission. You can, of course, customize the rules as
you like. One suggestion would be to incorporate the value of the
`--as` option into your rules, allowing you to restrict execution
based on the Twitter account the command will use. For example, the rule

    when command is twitter:tweet with option[as] == "support" must have twitter:tweet and site:support

would make it so only support team members (assuming you've granted
those people the `site:support` permission) could tweet from your
support Twitter account.

# Installing

    curl -O https://raw.githubusercontent.com/cogcmd/twitter/master/config.yaml
    cogctl bundle install config.yaml

# Building

To build the Docker image, simply run:

    $ rake image

Requires Docker and Rake.
