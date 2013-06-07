# Language Identifier

The language identifier takes raw text and returns the language of said text.

## Requirements

* Perl 5
* Ruby 1.9.2 or newer
* Make

## Developers

See how to edit / change / compile this gem at the bottom of this file.

## Installation

Add this line to your application's Gemfile:

    gem 'opener-language-identifier',
        :git=>"git@github.com:opener-project/language-identifier.git"

And then execute:

    $ bundle install

Or install it as a standalone gem:

    $ gem specific_install opener-language-identifier \
        -l https://github.com/opener-project/language-identifier.git

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
