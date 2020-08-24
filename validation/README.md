# DIME-Schematron 

These schematron rules contain some project specific constraints as well as rules which are not covered in the [MEI 3.0](https://music-encoding.org/guidelines/v3/content/) (DIME-customized) schema and its embedded schematron rules. 

## Usage Notes
The most convinient way is to use the oXygen XML editor project file ( `validation.xpr` ) which contains all needed settings.

* To validate an MEI file use  `src/rules/main.sch` 
* Making changes:
  * for the rules which follow generic patterns use DITA documents in the `src/topics/*`. Note that underlying *abstract schematron rules* are defined in `src/rules/library.sch`
	* for the unique rules use `src/rules/unique_rules.sch`
  * Apply the transformation scenario _extractRules_ . (The scenario can be applied on any file as its input is defined in the scenario statically.)

* For generating the documenatation, two separate transformation scenarios are used:
  1. `docs_unique-rules`  (should be applied on `uniqueRules.sch`) 
  2. `docs_framework` (should be applied on `styleguide.ditamap`)