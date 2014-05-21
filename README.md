[![Build Status](https://drone.io/github.com/opener-project/language-identifier/status.png)](https://drone.io/github.com/opener-project/language-identifier/latest)

# Language Identifier

The language identifier takes raw text and tries to figure out what language it
was written in. The output can either be a plain-text i18n language code or a basic
KAF document containing the language and raw input text.

The output of the language identifier can then be used to drive further text
analysis of for example sentiments and or entities.

### Confused by some terminology?

This software is part of a larger collection of natural language processing
tools known as "the OpeNER project". You can find more information about the
project at (the OpeNER portal)[http://opener-project.github.io]. There you can
also find references to terms like KAF (an XML standard to represent linguistic
annotations in texts), component, cores, scenario's and pipelines.

Quick Use Example
-----------------

Install the Gem:

    gem install opener-language-identifier

Make sure you run ```jruby``` since the language-identifier uses Java.

### Command line interface

You should now be able to call the language indentifier as a regular shell
command: by its name. Once installed the gem normalyl sits in your path so you can call it directly from anywhere.

This aplication reads a text from standard input in order to identify the language.

    echo "This is an English text." | language-identifier

This will output:

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<KAF xml:lang="en" version="2.1">
  <raw>This is an English text.
</raw>
</KAF>
```

If you just want the language code returned add the ```--no-kaf``` option like
this

    echo "This is an English text." | language-identifier --no-kaf

For more information about the available CLI options run the following:

    language-identifier --help

### Webservice

You can launch a language identification webservice by executing:

    $ language-identifier-server

This will launch a mini webserver with the webservice. It defaults to port 9292,
so you can access it at <http://localhost:9292>.

To launch it on a different port provide the `-p [port-number]` option like
this:

    language-identifier-server -p 1234

It then launches at <http://localhost:1234>

Documentation on the Webservice is provided by surfing to the urls provided
above. For more information on how to launch a webservice run the command with
the ```-h``` option.

### Daemon

Last but not least the language identifier comes shipped with a daemon that
can read jobs (and write) jobs to and from Amazon SQS queues. For more
information type:

    $ language-identifier-daemon -h

Description of dependencies
---------------------------

This component runs best if you run it in an environment suited for OpeNER
components. You can find an installation guide and helper tools in the (OpeNER
installer)[https://github.com/opener-project/opener-installer] and (an
installation guide on the Opener
Website)[http://opener-project.github.io/getting-started/how-to/local-installation.html]

At least you need the following system setup:

### Depenencies for normal use:

* Python 2.6 - PIP, possibly VirtualEnv
* Jruby
* Java 1.7 or newer (There are problems with encoding in older versions).

### Dependencies if you want to modify the component:

* Maven (for building the Gem)

Language Extension
------------------

  TODO

The Core
--------
  
The component is a fat wrapper around the actual language technology core.
Written Java. Checkout the core/src directory of the package to get to the
actual working component.

Where to go from here
---------------------

* Check (the project website)[http://opener-project.github.io]
* (Checkout the webservice)[http://opener.olery.com/language-identifier]

Report problem/Get help
-----------------------

If you encounter problems, please email support@opener-project.eu or leave an
issue in the (issue tracker)[https://github.com/opener-project/language-identifier/issues]. 

Contributing
------------

1. Fork it ( http://github.com/opener-project/language-identifier/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
