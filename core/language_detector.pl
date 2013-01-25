#!/usr/bin/perl
use warnings;
use strict;
use lib "../lib/";
use lib "./lib/";

use Text::Language::Guess ;

if (scalar(@ARGV) < 2) {
	print "\nVicomtech-language-identifier-lite_kernel needs 2 arguments:\n\n";
	print "1. Language support. With '0' suports:\n\n";
	print "\tEnglish (en)\n\tFrench (fr)\n\tSpanish (es)\n\tItalian (it)\n\tGerman (de)\n\tDutch (nl)\n\n";
	print "   With '1' suports:\n\n";
	print "\tEnglish (en)\n\tFrench (fr)\n\tSpanish (es)\n\tPortugese (pt)\n\tItalian (it)\n\tGerman (de)\n\tDutch (nl)\n\tSwedish (sv)\n\tNorwegian (no)\n\tDanish (da)\n\n";
	print "2. The file path whose language will be guessed.\n\n";
	
} else {
	my $support = $ARGV[0];
	my $file = $ARGV[1];
	my $guesser;
	if ($support == 1) {
		$guesser = Text::Language::Guess->new();
	} else {
		$guesser = Text::Language::Guess->new(languages => ['en', 'fr', 'es', 'it', 'de', 'nl']);
	}
        my $lang = $guesser->language_guess($file);
	if ($lang) {
		print "$lang\n";
	} else {
		print "Error: unknown language.";
	}
}
