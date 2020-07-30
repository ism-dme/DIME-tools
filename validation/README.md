# DIME-Schematron 
___

The project contains an implementation of the schematron rules which were developed in the context of  the [Digital Interactive Mozart Edition][1]. They meant to be an extension of the [MEI 3.0][3] (DIME-customized) schema and its embedded schematron rules. Although, there are many project specific rules, some of them may be useful for the MEI validation in general.

___

## Usage Notes

* Open `dime-schematron.xpr` with oXygen XML Editor
* To define the rules use the following files:
  * for the rules which follow generic patterns use DITA documents in the `src/topics/*`. Note that underlying *abstract schematron rules* are defined in `src/rules/library.sch`
	* for the unique rules use `src/rules/unique_rules.sch`
* Apply the transformation scenario _extractRules_ (it builds the files `main.sch` and `quickFix-library.xml`). The scenario can be applied on any file as its input is defined in the scenario statically 
* To validate an MEI file use  `src/rules/main.sch` 
* For generating the documenatation, two separate scenarios are currently used:
  1. `docs_unique-rules`  (should be applied on `uniqueRules.sch`) 
  2. `docs_framework` (should be applied on `styleguide.ditamap`)


___


## Disclaimer
The project uses following parts from the [Intelligent Integrated Style Guide][2] by Syncro Soft SRL (2018):

- the `styleguide` framework
- the `src` folder. The files in this folder were modified to meet the project needs, in particular, in order to be able to define the *unique rules* 

___

[1]: https://dme.mozarteum.at/en/music/edition/
[2]: https://github.com/oxygenxml/integrated-styleguide
[3]: https://music-encoding.org/guidelines/v3/content/