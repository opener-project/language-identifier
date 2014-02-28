Feature: Using a file and an argument as input and other file as an output
  In order to detect file's language
  Using a file as an input
  Using a file as an output

  Scenario Outline: detect input file's language

    Given the fixture file "<input_file>"
    Then the output should match "<language>"
  Examples:
    | input_file  | language |
    | english.txt | en       |
    | spanish.txt | es       |
    | french.txt  | fr       |
    | german.txt  | de       |
    | italian.txt | it       |
    | dutch.txt   | nl       |

