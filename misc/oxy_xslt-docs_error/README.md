# oXygen documentation error

Creating XSLT-documentation with oXygen 20.1 can cause error containing
missing `$refText` variable. oXygen developers provide a patch `patch.jar` for this
error:


In the Oxygen installation folder in the "lib" directory create
another directory called "endorsed" and copy the `patch.jar` there. Then
restart Oxygen and try again to create documentation from the XSLT
stylesheet.
