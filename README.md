rSHARK
======
rSHARK provides an R library for create Apache Spark dataframes from the MongoDB created by the SmartSHARK platform. The data can then be analyzed with [SparkR](https://spark.apache.org/docs/latest/sparkr.html).

Prerequistes
============
A prerequiste for using rSHARK is a working installation of SparkR. A guide for the installation, including on how to load SparkR with RStudio can be found online, e.g., [here](https://github.com/apache/spark/tree/master/R).

Installation
============

Once SparkR is running, rSHARK can be installed directly from this repository using the [devtools](https://cran.r-project.org/web/packages/devtools/index.html):
```R
if (!require("devtools")) install.packages("devtools")
library(devtools)
install_github("smartshark/rSHARK")
```
You can then load the rSHARK library with the standard command:
```R
library(rSHARK)
```

## Execution
### via RStudio
rSHARK uses mongoDB where the data is stored.MongoDB must be running before running any function.rSHARK also need sparkSession to be initilized and passed form outside.To initilize [SparkSession](http://spark.apache.org/docs/latest/sparkr.html) you can run:

    sparkSession<-sparkR.session(master = "LINK_TO_MASTER",sparkConfig = list(spark.driver.memory = "2g",spark.driver.extraClassPath =      
    "PATH_TO_JAR", spark.driver.extraLibraryPath = "PATH_TO_JAR",spark.driver.extraJavaOptions = "JAVA_OPTIONS") ,sparkJars = "PATH_TO_JAR" )
    
 Create MongoDBUtils by running following code
 
      mongoDBUtils<-rShark.createMongoDBUtils(sparkSession)   
  

## Examples
Create Spark Session by running following command:
    
    sparkSession<-sparkR.session(master = "local[5]",sparkConfig = list(spark.driver.memory = "2g",spark.driver.extraClassPath =     "F:/Development/sparkSHARK.jar", spark.driver.extraLibraryPath = "F:/Development/sparkSHARK.jar",spark.driver.extraJavaOptions = 
    "-Dspark.exectutorEnv.dbtuils.type=mongo -Dspark.executorEnv.mongo.uri=127.0.0.1 -Dspark.executorEnv.mongo.dbname=ping") ,sparkJars = "F:/Development/sparkSHARK.jar" )
    
Create MongoDBUtils by calling following funcation:

    mongoDBUtils<-rShark.createMongoDBUtils(sparkSession)
    
Load Data from Mongo to Spark by calling the following funcation:

    rShark.loadData(mongoDBUtils,"tag")


 
