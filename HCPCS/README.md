# HCPCS

Data files are downloaded from [CMS.gov](https://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets/Alpha-Numeric-HCPCS.html)

Usage example:

```
source("readHCPCS.R")
D <- rbindlist(list(readHCPCS("12anweb.zip"),
                    readHCPCS("13anweb.zip"),
                    readHCPCS("14anweb.zip"),
                    readHCPCS("2015-Annual-Alpha-Numeric-HCPCS-File.zip"),
                    readHCPCS("2016-Alpha-Numeric-HCPCS-File.zip")))
```
