  Feature: Export files can be created with the correct data

  Scenario Outline: A case is loaded, action rule triggered and export file created with differing templates with UACs
    Given sample file "<sample file>" is loaded successfully
    And an export file template has been created with template "<template>"
    When an export file action rule has been created for packcode "<template>"
    Then UAC_UPDATE messages are emitted with active set to true
    And an export file is created with correct rows
    And the events logged against the cases are ["NEW_CASE","EXPORT_FILE"]

    Examples:
      | sample file                          | template |
      | sample_input_england_census_spec.csv | P_IC_ICL1  |
      | sample_input_england_census_spec.csv | P_IC_ICL2B |

    @regression
    Examples:
      | sample file                             | template    |
      | sample_input_england_census_spec.csv    | P_IC_H1     |
      | sample_input_england_census_spec.csv    | P_IC_H2     |
      | sample_1_input_england_census_spec.csv  | P_IC_ICL3   |
      | sample_1_input_england_census_spec.csv  | P_IC_ICL3A  |
      | sample_1_input_england_census_spec.csv  | P_RL_1IRL1  |
      | sample_1_input_england_census_spec.csv  | P_RL_1IRL2B |
      | sample_1_input_england_census_spec.csv  | P_RL_1IRL3  |
      | sample_1_input_england_census_spec.csv  | P_RL_2IRL1  |
      | sample_1_input_england_census_spec.csv  | P_RL_2IRL2B |
      | sample_1_input_england_census_spec.csv  | P_RL_2IRL3  |


  Scenario Outline: A case is loaded, action rule triggered and export file created with a template with no UAC
    Given sample file "<sample file>" is loaded successfully
    And an export file template has been created with template "<template>"
    When an export file action rule has been created for packcode "<template>"
    Then an export file is created with correct rows
    And the events logged against the cases are ["NEW_CASE","EXPORT_FILE"]

    Examples:
      | sample file                          | template    |
      | sample_input_england_census_spec.csv | P_IC_PCPR1  |

    @regression
    Examples:
      | sample file                             | template     |
      | sample_1_input_england_census_spec.csv  | P_IC_PCPR2B  |
      | sample_1_input_england_census_spec.csv  | P_IC_PCPR13  |
      | sample_1_input_england_census_spec.csv  | P_IC_PCPR23  |
      | sample_1_input_england_census_spec.csv  | P_IC_PCPR13A |
      | sample_1_input_england_census_spec.csv  | P_IC_PCPR23A |

  Scenario: Export file headers are sanitised to ISD-compliant names
    Given sample file "sample_input_england_census_spec.csv" is loaded successfully
    And an export file template has been created with template "P_OR_H2"
    When an export file action rule has been created for packcode "P_OR_H2"
    Then UAC_UPDATE messages are emitted with active set to true
    And an export file is created with correct rows
    And the export file header row is sanitised according to:
      | template_key         | header_name |
      | __pack_code__        | PRODUCTPACK_CODE |
      | __uac__              | UAC         |
      | __qid__              | QID         |
      | __welsh_uac__        | WALES_UAC   |
      | __welsh_qid__        | WALES_QID   |
      | __caseref__          | CASEREF     |
      | __request__.title    | TITLE       |
      | __request__.forename | FORENAME    |
      | __request__.surname  | SURNAME     |
      | ADDRESS_LINE1        | ADDRESS_LINE1 |
      | ADDRESS_LINE2        | ADDRESS_LINE2 |
      | ADDRESS_LINE3        | ADDRESS_LINE3 |
      | TOWN_NAME            | TOWN_NAME   |
      | POSTCODE             | POSTCODE    |
