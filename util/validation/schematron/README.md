# DIME-Schematron 

These schematron rules contain some project specific constraints as well as rules which are not covered in the MEI 3.0.0/4.0l0 DIME-customized [schema](https://dme.mozarteum.at/DME/schemata/mei-DME.rng) and its embedded schematron rules. 

## Usage Notes

* To validate an MEI file use  `src/rules/main.sch` 
* Making changes:
  * for the rules which follow generic patterns use DITA documents in the `src/topics/*`. Note that underlying *abstract schematron rules* are defined in `src/rules/library.sch`
	* for the unique rules use `src/rules/unique_rules.sch`
  * Apply the transformation scenario _\_schematron\_extractRules_ on the 
`./validation/schematron/src/styleguide.ditamap`

* For generating the documenatation, two separate transformation scenarios are used:
  1. `docs_unique-rules`  (should be applied on `uniqueRules.sch`) 
  2. `documentation` (should be applied on `styleguide.ditamap`)
  
Tested with <oXygen\\> XML Editor 20.1, build 2020010914