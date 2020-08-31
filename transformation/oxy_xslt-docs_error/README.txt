When you want to create XSLT-documentation with oXygen built in scenario and you get an error about
$refText...


Hi Oleksii,

I can reproduce the problem and I added an internal issue to fix it on
our side.
In the meantime I can provide a patch for it, you can download the library:

www.oxygenxml.com/userFiles/patch.jar

then in the Oxygen installation folder in the "lib" directory create
another directory called "endorsed" and copy the "patch.jar" there. Then
restart Oxygen and try again to create documentation from the XSLT
stylesheet.

The patch is a temporary workaround, one of the references in the XSLT
documentation may be broken but we'll try to understand the problem and
have a proper fix for it in a future release.

Regards,
Radu

Radu Coravu
<oXygen/> XML Editor
www.oxygenxml.com