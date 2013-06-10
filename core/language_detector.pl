#!/usr/bin/env perl

use warnings;
use strict;
use FindBin;

# Used to load the modules from the directory this script is located in
# (instead of the current working directory).
use lib "$FindBin::Bin/lib";
use lib "$FindBin::Bin/lib/built";

use Text::Language::Guess ;

my $HELP = 0;
my $SUPPORT = 0;

if (scalar(@ARGV) > 0) {
    for (my $i=0; $i < scalar(@ARGV) && $HELP==0; $i++) {
        if ($ARGV[$i] eq "--help") {
            $HELP = 1;
        }
        elsif ($ARGV[$i] eq "-d") {
            $SUPPORT = 1;
        }
    }
}

if ($HELP == 1) {
    displayHelp();
}
else {
    my $text ="";

    while(<STDIN>) {
        $text .= $_;
    }

    my $guesser;

    if ($SUPPORT == 1) {
        $guesser = Text::Language::Guess->new();
    }
    else {
        $guesser = Text::Language::Guess->new(languages => ['en', 'fr', 'es', 'it', 'de', 'nl']);
    }

    my $lang = $guesser->language_guess_string($text);

    if ($lang) {
        print "$lang\n";
    }
    else {
        print STDERR "Error: unknown language.";
        exit 1;
    }

}

##
# NOTE: the wrapper around this script actually hijacks the help output, which
# means that the message below never get's displayed.
#
# In order to change the help output check the file:
# lib/opener/language-identifier/option_parser.rb
#
sub displayHelp {
    print STDERR "\nThis aplication reads a text from standard input in order to identify language.\n\n";
    print STDERR "Usage: cat english.txt | language-identifier\n\n";
    print STDERR "-d,             (optional) extends language detection,\n";
    print STDERR "                without this flag application detects:\n";
    print STDERR "                english (en), french (fr), spanish (es), italian (it),\n";
    print STDERR "                german (de) and dutch (nl).\n";
    print STDERR "                with this flag application detects:\n";
    print STDERR "                english (en), french (fr), spanish (es), portugese (pt),\n";
    print STDERR "                italian (it), german (de), dutch (nl), swedish (sv),\n";
    print STDERR "                norwegian (no) and danish (da).\n";
    print STDERR "--help,         outputs aplication help.\n\n";
}
