#Pet-poc-templates

Module implements xsl import and implements custom tag `<full-import href="child.xsl" ignore-namespaces="true"/>`.
This tag allows including content from any xls file from resource folder.
All content of included file will be copied to destination stylesheet.

##Tag attributes:
* **href** - relative path to included xls file in **_resource_** folder;
* **ignore-namespaces** - allows removing attributes that starts from **xmlns:** in root tag of imported xls.
  This feature allows to have syntax highlighting in included _xls_ files. Example in **_xsl-main-import-relative.xsl(xsl-1-relative.xsl import)_**.

To run example you can execute `com.efx.pet.batch.RelativeImportMain` from IDE.
It uses _**xsl-main-import-relative.xsl**_ file as an input xls (with imports) and _**simple.xml**_ as a data for it and produces `xls-out-relative.xsl` file in root directory.
Example with pdf generation located in **pet-poc-font** module.

##How it works
Main functionality located in `XslService` class.
Method `resolveImportTags` processes master xls file and replaces all `full-import` tags with content of included files.
Method returns **_byte array_** as a result of new xls files that can be used in future for _**pdf**_ generation.
Current implementation doesn't support imports in included files.
