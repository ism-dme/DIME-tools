# MoVi Unit Tests

The folder contains unit tests for `/assets/xsl/dme-app.xsl`.
To run the tests execute following commands:

- `cd unit_tests`
- `python3 ./run_unit_tests.py <path-to-xspec-files>` (Linux)
- `python3 .\run_unit_tests.py <path-to-xspec-files>` (Windows)

Current `<path-to-xspec-files>` are:

 - `./xsl`
 - `../assets/xsl/origScoring/unit_tests`
 - `../assets/xsl/extractParts/unit_tests`

### Disclaimer
The tests are implemented using the[XSpec framework](https://github.com/xspec/xspec) which is published under [MIT Licene](https://github.com/xspec/xspec/blob/master/LICENSE) as well as [Mozilla Public License] (https://www.mozilla.org/en-US/MPL/).