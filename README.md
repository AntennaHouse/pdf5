Antenna House PDF5 Plugin
=========================
PDF5 is the plug-in for [DITA Open Toolkit] [3]. It converts [DITA] [5] document into [XSL-FO] [6] and generates PDF file.     
This plug-in works with DITA Open Toolkit 1.6.3 or later and uses [Antenna House Formatter] [4] for generating PDF file.

CONTENTS
--------
 - Root Files
 - com.antennahouse.pdf5 Folder
 - index-data Folder
 - Notices Folder
 - Revision

Root files
----------
- README.md  
  This file.

- pdf5_manual.pdf  
  Plug-in user's manual. To use plug-in read this first.

- ahf-setting.xml  
  Antenna House Formatter sample setting file.

- run_en.bat, run_ja.bat  
  Sample batch file to generate PDF from sample data with DITA-OT.

com.antennahouse.pdf5 folder
----------------------------
This folder contains PDF5 plug-in files and folders. To install this plug-in, 
refer to pdf5_manual.pdf.

jp.acme-corporation.pdf folder
----------------------------
This folder contains sample plug-in that overrides PDF5 plug-in for your own customization.

index-data folder
-----------------
This folder contains DITA sample files. The sample files covers en, 
ja languages.

notices folder
--------------
The notices folder contains license files related to this plug-in.

test-result folder
------------------
This folder contains PDF files made from test data using DITA Open Toolkit.

Copyright
---------
Copyright (C) 2009-2015 Antenna House, Inc. All rights reserved.  
Antenna House is a trademark of [Antenna House, Inc.] [2]

License
-------
This software is licenced under the [Apache License, Version 2.0] [1].

Important Notification
----------------------
Because the successor [PDF-ML] [7] has been released, we will stop development of this plug-in at the end of January, 2016. If you have any development request for this plug-in please mail to [Antenna House Information] [8]. We will supply development for a fee.  

[1]: http://www.apache.org/licenses/LICENSE-2.0 "Apache License, Version 2.0"
[2]: http://www.antennahouse.com/ "Antenna House, Inc."
[3]: http://sourceforge.net/projects/dita-ot/ "DITA Open Toolkit"
[4]: http://antennahouse.com/product.htm "Antenna House Formatter"
[5]: https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=dita "OASIS Darwin Information Typing Architecture (DITA)"
[6]: http://www.w3.org/TR/xsl/ "XSL Formatting Object"
[7]: https://github.com/AntennaHouse/pdf5-ml "PDF5-ML"
[8]: mailto:info@antennahouse.com "Antenna House"