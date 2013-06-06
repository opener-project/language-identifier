Vicom-language-identifier-lite_kernel
=====================================

Kernel for language detection lite version.

## Prerequisites

  * Perl installed

## Installation

_Note: During gem installation a perl module will be installed and compiled
locally._

Add this line to your application's Gemfile:

    gem 'opener-language-identifier', :git=>"git@github.com:opener-project/language-identifier.git"

And then execute:

    $ bundle install

Or install it as a standalone gem:

    $ gem specific_install opener-language-identifier -l https://github.com/opener-project/language-identifier.git

## Usage

Once installed as a gem you can access the gem from anywhere:

This aplication reads a text from standard input in order to identify language.

Usage: language-identifier [OPTION]

-d,	(optional) extends language detection,

	without this flag application detects:
	english (en), french (fr), spanish (es), italian (it),
	german (de) and dutch (nl).

	with this flag application detects:
	english (en), french (fr), spanish (es), portugese (pt),
	italian (it), german (de), dutch (nl), swedish (sv),
	norwegian (no) and danish (da).

--help,	outputs aplication help.

Example: cat english_text.txt | language-identifier -d

Will output:

en

## Contributing

1. Pull it
2. Create your feature branch (`git checkout -b features/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin features/my-new-feature`)
5. If you're confident, merge your changes into master.
