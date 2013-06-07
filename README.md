# Language Identifier

The language identifier takes raw text and returns the language of said text.

## Requirements

* Perl 5
* Ruby 1.9.2 or newer
* Make

## Developers

See how to edit / change / compile this gem at the bottom of this file.

## Installation

### As part of a Gemfile in a Ruby application

Add this line to your application's Gemfile:

    gem 'opener-language-identifier',
        :git=>"git@github.com:opener-project/language-identifier.git"

And then execute:

    $ bundle install

### As a standalone GEM:

Make sure you have the ```specific_install``` gem installed first by running

    $ gem install specific_install

After that you can install the gem from the git repository like this:

    $ gem specific_install opener-language-identifier \
        -l https://github.com/opener-project/language-identifier.git

Once the gem is installed you have access to the following command from
anywhere on your computer:

    $ echo "this is an english text" | language-identifier

or you can launch a webservice with

    $ language-identifier-server

Enjoy!

## Usage

Detecting a language:

    echo "This is English text" | language-identifier

Using extended language detection:

    echo "Dit is een Nederlandse text" | language-identifier -d

For more information about the usage and available options run the following:

    language-identifier --help

### Outputting KAF

The language detector is capable of outputting a KAF file include the original
text. You can do so like this:

    echo "This is an english text" | language-identifier --KAF

Will result in

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><KAF xml:lang="en"><raw>This is an english text </raw></KAF>

## Server

The language identifier comes equipped with a simple webservice. To start the
webservice type:

    language-identifier-server

This will launch a mini webserver with the webservice. It defaults to port 9292,
so you can access it at:

    http://localhost:9292

To launch it on a different port provide the ```-p [port-number]``` option like
this:

    language-identifier-server -p 1234

It then launches at ```http://localhost:1234```

Documentation on the Webservice is provided by surfing to the urls provided
above. 


## Contributing

### Compiling Perl

The Gem comes with various Perl dependencies that are vendored, including one C
extension. This extension is compiled upon Gem installation or when running the
following command:

    rake compile

### Hacking

First install the required dependencies:

    bundle install

Then run the tests to see if everything is working:

    rake

This will compile the Perl code and run the tests. If you want to recompile the
Perl code without running tests at some point you can run the following:

    rake compile

### Procedure

1. Pull it
2. Create your feature branch (`git checkout -b features/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin features/my-new-feature`)
5. If you're confident, merge your changes into master.

# What's next? 

If you're interested in the language-identifier, you also might want to check
out opener-project/tokenizer-base.
