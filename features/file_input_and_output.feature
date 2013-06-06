Feature: Using a file and an argument as input and other file as an output
  In order to detect file's language
  Using a parameter as language coverage
  Using a file as an input
  Using a file as an output

  Scenario Outline: detect input file's language, without language coverage flag the aplication detects:

	English (en)
	French (fr)
	Spanish (es)
	Italian (it)
	German (de)
	Dutch (nl)

  With language coverage flag it detects:

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

    Given a parameter as language coverage "<language_coverage>"
    Given the fixture file "<input_file>"
    And I put them through the kernel
    Then the output should match the fixture "<output_file>"
  Examples:
    | language_coverage | input_file    | output_file          |
    |                   | english.txt   | english_result.txt   |
    |                   | spanish.txt   | spanish_result.txt   |
    |                   | french.txt    | french_result.txt    |
    |                   | german.txt    | german_result.txt    |
    |                   | italian.txt   | italian_result.txt   |
    |                   | dutch.txt     | dutch_result.txt     |
    | -d                | english.txt   | english_result.txt   |
    | -d                | spanish.txt   | spanish_result.txt   |
    | -d                | french.txt    | french_result.txt    |
    | -d                | german.txt    | german_result.txt    |
    | -d                | italian.txt   | italian_result.txt   |
    | -d                | dutch.txt     | dutch_result.txt     |
    | -d                | danish.txt    | danish_result.txt    |
    | -d                | norwegian.txt | norwegian_result.txt |
    | -d                | portugese.txt | portugese_result.txt |
    | -d                | swedish.txt   | swedish_result.txt   |
