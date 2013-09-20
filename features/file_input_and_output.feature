Feature: Using a file and an argument as input and other file as an output
  In order to detect file's language
  Using a file as an input
  Using a file as an output

  Scenario Outline: detect input file's language

    Given the fixture file "<input_file>"
    And I put them through the kernel
    Then the output should match the fixture "<output_file>"
  Examples:
    | input_file    | output_file          |
    | english.txt   | english_result.txt   |
    | spanish.txt   | spanish_result.txt   |
    | french.txt    | french_result.txt    |
    | german.txt    | german_result.txt    |
    | italian.txt   | italian_result.txt   |
    | dutch.txt     | dutch_result.txt     |

