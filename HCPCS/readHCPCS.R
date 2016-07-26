readHCPCS <- function (filename) {
    require(data.table)
    urlStem <- "https://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets/Downloads"
    url <- file.path(urlStem, filename)
    f <- tempfile()
    download.file(url, f)
    filenames <- unzip(f, list=TRUE)[, "Name"]
    unzip(f, exdir=tempdir())
    f <- file.path(tempdir(), grep("((A-N)|(ANWEB)).*txt$", filenames, value = TRUE, ignore.case = TRUE))
    colInfo <- matrix(c("HCPCS_CD", "5", "character",
                        "HCPCS_SQNC_NUM", "5", "integer",
                        "HCPCS_REC_IDENT_CD", "1", "character",
                        "HCPCS_LONG_DESC_TXT", "80", "character",
                        "HCPCS_SHORT_DESC_TEXT", "28", "character",
                        "HCPCS_PRCNG_IND_CD1", "2", "character",
                        "HCPCS_PRCNG_IND_CD2", "2", "character",
                        "HCPCS_PRCNG_IND_CD3", "2", "character",
                        "HCPCS_PRCNG_IND_CD4", "2", "character",
                        "HCPCS_MLTPL_PRCNG_IND_CD", "1", "character",
                        "HCPCS_CIM_RFRNC_SECT_NUM1", "6", "character",
                        "HCPCS_CIM_RFRNC_SECT_NUM2", "6", "character",
                        "HCPCS_CIM_RFRNC_SECT_NUM3", "6", "character",
                        "HCPCS_MCM_RFRNC_SECT_NUM1", "8", "character",
                        "HCPCS_MCM_RFRNC_SECT_NUM2", "8", "character",
                        "HCPCS_MCM_RFRNC_SECT_NUM3", "8", "character",
                        "HCPCS_STATUTE_NUM", "10", "character",
                        "HCPCS_LAB_CRTFCTN_CD1", "3", "character",
                        "HCPCS_LAB_CRTFCTN_CD2", "3", "character",
                        "HCPCS_LAB_CRTFCTN_CD3", "3", "character",
                        "HCPCS_LAB_CRTFCTN_CD4", "3", "character",
                        "HCPCS_LAB_CRTFCTN_CD5", "3", "character",
                        "HCPCS_LAB_CRTFCTN_CD6", "3", "character",
                        "HCPCS_LAB_CRTFCTN_CD7", "3", "character",
                        "HCPCS_LAB_CRTFCTN_CD8", "3", "character",
                        "HCPCS_XREF_CD1", "5", "character",
                        "HCPCS_XREF_CD2", "5", "character",
                        "HCPCS_XREF_CD3", "5", "character",
                        "HCPCS_XREF_CD4", "5", "character",
                        "HCPCS_XREF_CD5", "5", "character",
                        "HCPCS_CVRG_CD", "1", "character",
                        "HCPCS_ASC_PMT_GRP_CD", "2", "character",
                        "HCPCS_ASC_PMT_GRP_EFCTV_DT", "8", "character",
                        "HCPCS_MOG_PMT_GRP_CD", "3", "character",
                        "HCPCS_MOG_PMT_PLCY_IND_CD", "1", "character",
                        "HCPCS_MOG_PMT_GRP_EFCTV_DT", "8", "character",
                        "HCPCS_PRCSG_NOTE_NUM", "4", "character",
                        "HCPCS_BETOS_CD", "3", "character",
                        "FILLER", "1", "character",
                        "HCPCS_TYPE_SRVC_CD1", "1", "character",
                        "HCPCS_TYPE_SRVC_CD2", "1", "character",
                        "HCPCS_TYPE_SRVC_CD3", "1", "character",
                        "HCPCS_TYPE_SRVC_CD4", "1", "character",
                        "HCPCS_TYPE_SRVC_CD5", "1", "character",
                        "HCPCS_ANSTHSA_BASE_UNIT_QTY", "3", "integer",
                        "HCPCS_CD_ADD_DT", "8", "character",
                        "HCPCS_ACTN_EFCTV_DT", "8", "character",
                        "HCPCS_TRMNTN_DT", "8", "character",
                        "HCPCS_ACTN_CD", "1", "character",
                        "FILLER", "27", "character"),
                      ncol=3,
                      byrow=TRUE)
    colInfo <- data.table(colInfo)
    setnames(colInfo, names(colInfo), c("name", "width", "class"))
    colInfo <- colInfo[, width := as.integer(width)]
    hcpcs <- read.fwf(f,
                      widths=colInfo[, width],
                      col.names=colInfo[, name],
                      colClasses=colInfo[, class],
                      fill=TRUE,
                      strip.white=FALSE,
                      stringsAsFactors=FALSE)
    data.table(hcpcs)
}
