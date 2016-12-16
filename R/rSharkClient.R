#' Create MongoDBUtils Function
#'
#' This function creates MongoDBUtils on backend.
#' @name rShark.createMongoDBUtils 
#' @param SparkSession Provided from outside with specific parameters.
#' @return MongoDBUtils 
#' @keywords mongodbutils
#' @export
#' @examples
#' rShark.createMongoDBUtils(SparkSession)

rShark.createMongoDBUtils <- function(sparkSession){
  mongoDBUtils <- sparkR.newJObject("de.ugoe.cs.smartshark.util.MongoDBUtils",sparkSession);
  mongoDBUtils
}

#' Call loadData Function
#'
#' This function calls loadData on backend.
#' @name rShark.loadData
#' @param mongoDBUtils To be provided on which loadData method is called.
#' @param collectionName To be provided for which data is retrived from backend.
#' @return SparkDataFrame 
#' @keywords loadData
#' @export
#' @examples
#' rShark.loadData (mongoDBUtils,collectionName)

rShark.loadData <- function(mongoDBUtils,collectionName){
  sparkDataFrame<- new("SparkDataFrame",sparkR.callJMethod(mongoDBUtils,"loadData",collectionName),FALSE) 
  sparkDataFrame
}

#' Call loadDataLogical Function
#'
#' This function calls loadDataLogical on backend.
#' @name rShark.loadDataLogical
#' @param mongoDBUtils To be provided on which loadDataLogical method is called.
#' @param collectionName To be provided for which data is retrived from backend.
#' @param logLists List of vectors of strings.
#' @return SparkDataFrame 
#' @keywords loadDataLogical
#' @export
#' @examples
#' rShark.loadDataLogical (mongoDBUtils,collectionName,list(c("ProcessMetrics","ProductMetrics"), c("ID","Name")))

rShark.loadDataLogical <- function(mongoDBUtils,collectionName,logLists){
  logicalLists<-sparkR.newJObject("java.util.ArrayList")
  for(logList in logLists){
    logicalList<-sparkR.newJObject("java.util.ArrayList")
    for(logValue in logList){
      sparkR.callJMethod(logicalList,"add",logValue)
    }
    sparkR.callJMethod(logicalLists,"add",logicalList)
  }
  sparkDataFrame<- new("SparkDataFrame",sparkR.callJMethod(mongoDBUtils,"loadDataLogical",collectionName,logicalLists),FALSE) 
  sparkDataFrame
}


#' Call writeData Function
#'
#' This function calls writeData on backend.
#' @name rShark.writeData
#' @param mongoDBUtils To be provided on which writeData method is called.
#' @param dataFrame To be provided which is upserted in the Database.
#' @param collectionName To be provided where Data will be upserted.
#' @keywords writeData
#' @export
#' @examples
#' rShark.writeData (mongoDBUtils,dataFrame,collectionName)

rShark.writeData <- function(mongoDBUtils,dataFrame,collectionName){
  sparkR.callJMethod(mongoDBUtils,"writeData",dataFrame,collectionName)
}
