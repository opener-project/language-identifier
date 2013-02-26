Vicom-language-identifier-lite_kernel
=====================================

Kernel for language detection lite version.

## Prerequisites

  * Perl: Text/ExtractWords.pm

## Installation


Add this line to your application's Gemfile:

    gem 'Vicom-language-identifier-lite_kernel', :git=>"git@github.com/opener-project/Vicom-language-identifier-lite_kernel.git"

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem specific_install Vicom-language-identifier-lite_kernel -l https://github.com/opener-project/Vicom-language-identifier-lite_kernel.git

## Usage

Once installed as a gem you can access the gem from anywhere:

Vicomtech-language-identifier-lite_kernel needs 2 arguments:

1. Language support. With '0' suports:

	English (en)
	French (fr)
	Spanish (es)
	Italian (it)
	German (de)
	Dutch (nl)

   With '1' suports:

	English (en)
	French (fr)
	Spanish (es)
	Portugese (pt)
	Italian (it)
	German (de)
	Dutch (nl)
	Swedish (sv)
	Norwegian (no)
	Danish (da)

2. The file path whose language will be guessed.

For example:

$ Vicom-tokenizer-lite_FR 0 english.txt

Will output:

en


## Contributing

1. Pull it
2. Create your feature branch (`git checkout -b features/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin features/my-new-feature`)
5. If you're confident, merge your changes into master.
