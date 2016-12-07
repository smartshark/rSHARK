#' Create MongoDBUtils Function
#'
#' This function creates MongoDBUtil on backend.
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
#' @param collectionName To be provided for which data is retrived from backend.
#' @return SparkDataFrame 
#' @keywords loadData
#' @export
#' @examples
#' rShark.loadData (collectionName)

rShark.loadData <- function(mongoDBUtils,collectionName){
  sparkDataFrame<- new("SparkDataFrame",sparkR.callJMethod(mongoDBUtils,"loadData",collectionName),FALSE) 
  sparkDataFrame
}