Feature: Using a file and an argument as input and other file as an output
  In order to detect file's language
  Using a parameter as language coverage
  Using a file as an input
  Using a file as an output

  Scenario Outline: detect input file's language, if language coverage is "0" the aplication detects:

	English (en)
	French (fr)
	Spanish (es)
	Italian (it)
	German (de)
	Dutch (nl)

  If language coverage is "1" it detects:

	English (en)
	French (fr)
	Spanish (es)
	Italian (it)
	German (de)
	Dutch (nl)
	Portugese (pt)
	Swedish (sv)
	Norwegian (no)
	Danish (da)

    Given an argument as language coverage "<language_coverage>"
    Given the fixture file "<input_file>"
    And I put them through the kernel
    Then the output should match the fixture "<output_file>"
  Examples:
    | language_coverage	| input_file	| output_file		|
    | 0                 | english.txt	| english_result.txt	|
    | 0                 | spanish.txt	| spanish_result.txt	|
    | 0                 | french.txt	| french_result.txt	|
    | 0                 | german.txt	| german_result.txt	|
    | 0                 | italian.txt	| italian_result.txt	|
    | 0                 | dutch.txt	| dutch_result.txt	|
    | 1                 | english.txt	| english_result.txt	|
    | 1                 | spanish.txt	| spanish_result.txt	|
    | 1                 | french.txt	| french_result.txt	|
    | 1                 | german.txt	| german_result.txt	|
    | 1                 | italian.txt	| italian_result.txt	|
    | 1                 | dutch.txt	| dutch_result.txt	|
    | 1                 | danish.txt	| danish_result.txt	|
    | 1                 | norwegian.txt	| norwegian_result.txt	|
    | 1                 | portugese.txt	| portugese_result.txt	|
    | 1                 | swedish.txt	| swedish_result.txt	|
