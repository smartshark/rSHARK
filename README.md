rSHARK
======
rSHARK provides an R library for create Apache Spark dataframes from the MongoDB created by the SmartSHARK platform. The data can then be analyzed with [SparkR](https://spark.apache.org/docs/latest/sparkr.html).

Prerequistes
============
Two prerequisites are required:

1. A working installation of SparkR. The guide for the installation, including how to load SparkR with RStudio can be found [here](https://github.com/apache/spark/tree/master/R).
2. The sparkSHARK.jar file, which can be downloaded [here](link missing!).

Installation
============

Once SparkR is running, rSHARK can be installed directly from this repository using the [devtools](https://cran.r-project.org/web/packages/devtools/index.html):
```R
if (!require("devtools")) install.packages("devtools")
library(devtools)
install_github("smartshark/rSHARK")
```

Usage
=====

You first need to load SparkR and rSHARK:
```R
library(SparkR)
library(rSHARK)
```

Then, you must create a Spark session:
```R
sparkSession <- sparkR.session(master=LINK_TO_MASTER,
                               sparkConfig=list(spark.driver.memory="2g",
                                                spark.driver.extraClassPath="PATH_TO_JAR",
                                                spark.driver.extraLibraryPath="PATH_TO_JAR",
                                                spark.driver.extraJavaOptions=JAVA_OPTIONS),
                               sparkJars=PATH_TO_JAR)
```

You have to replace `LINK_TO_MASTER`, `PATH_TO_JAR`, and `JAVA_OPTIONS` with the correct values:
- `LINK_TO_MASTER`: the address of the Spark master (see [here](http://spark.apache.org/docs/latest/submitting-applications.html#master-urls))
- `PATH_TO_JAR`: location of the sparkSHARK.jar file.
- `JAVA_OPTIONS`: arguments to to the JVM used for the Spark execution. These arguments should be used to setup the data base connection, as described [here](link missing!).

## Execution
    
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


 
