#pet-poc-fonts

This module allows building standalone app to produce a PDF from XSLs, that runs with command line params:

`java -jar xsltopdf.jar -xsl <path to input xsl file> - xml <path to input xml file> -pdf <path to output pdf file> -open`

Parameters:
* **-pdf** `<arg>`    path to output pdf file
* **-xml** `<arg>`    path to input xml file
* **-xsl** `<arg>`    path to input xsl file
* -help `[optional]`,  show help
* -open`[optional]`,  open generated pdf file in default pdf viewer


To build project execute such command in terminal: `mvn clean install` and result jar will be located in **target** directory with name **xsltopdf.jar**
Application use absolute paths to files. But if you want run it from IDE - you can use `com.efx.pet.batch.IdeRunner`, it uses templates from resource folder.

##How it works
Application loads **xml** file and parse it into instance of CreditReport class.
Then stylesheet (passed as **-xsl** argument) applied to credit report to produce result pdf (passed as **-pdf** argument) document.