getSynPUF <- function (zipFile) {
  # [CMS 2008-2010 Data Entrepreneurs' Synthetic Public Use File (DE-SynPUF)](https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DE_Syn_PUF.html)
  # 
  # Examples:
  #
  # > getSynPUF("DE1_0_2008_to_2010_Carrier_Claims_Sample_1A.zip")
  # > getSynPUF("DE1_0_2008_to_2010_Carrier_Claims_Sample_1B.zip")
  # > getSynPUF("DE1_0_2010_Beneficiary_Summary_File_Sample_1.zip")
  # 
  require(readr)
  require(data.table)
  urlStem <- "https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads"
  url <- file.path(urlStem, zipFile)
  path <- tempdir()
  f <- tempfile()
  download.file(url, f, mode = "wb")
  csvFile <- as.character(unzip(f, list = TRUE)["Name"])
  unzip(f, files = csvFile, exdir = path)
  D <- read_csv(file.path(path, csvFile))
  D <- data.table(D)
  setnames(D, names(D), tolower(names(D)))
  setkey(D, desynpuf_id)
  D
}