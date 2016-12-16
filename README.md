rSHARK
======
rSHARK provides an R library for creating Apache Spark dataframes with SmartSHARK data. The data can then be analyzed with [SparkR](https://spark.apache.org/docs/latest/sparkr.html).

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
sparkSession <- sparkR.session(master=SPARK_MASTER,
                               sparkConfig=list(spark.driver.memory="2g",
                                                spark.driver.extraClassPath="SPARKSHARK_JAR",
                                                spark.driver.extraLibraryPath="SPARKSHARK_JAR",
                                                spark.driver.extraJavaOptions=JAVA_OPTIONS),
                               sparkJars=SPARKSHARK_JAR)
```

You have to replace `SPARK_MASTER`, `SPARKSHARK_JAR`, and `JAVA_OPTIONS` with the correct values:
- `SPARK_MASTER`: the address of the Spark master (see [here](http://spark.apache.org/docs/latest/submitting-applications.html#master-urls))
- `SPARKSHARK_JAR`: location of the sparkSHARK.jar file.
- `JAVA_OPTIONS`: arguments to to the JVM used for the Spark execution. These arguments should be used to setup the data base connection, as described [here](https://github.com/smartshark/sparkSHARK#dbutils).

Using the Spark session, you can initialize the database utilities for accessing the data:
```R
mongoDBUtils <- rShark.createMongoDBUtils(sparkSession)
```

You can then use the `rShark.loadData()` and `rShark.loadDataLogical()` commands for accessing the data. 

Examples
========

Example 1: Initialize a local Spark and a local MongoDB
--------------------------------------------
```R
SPARK_MASTER <- local[*]
SPARKSHARK_JAR <- "/users/jsmith/jars/sparkSHARK.jar"
JAVA_OPTIONS <- paste("-Dspark.exectutorEnv.dbtuils.type=mongo",
                      "-Dspark.executorEnv.mongo.uri=localhost",
                      "-Dspark.executorEnv.mongo.port=27017",
                      "-Dspark.executorEnv.mongo.dbname=smartshark")

sparkSession <- sparkR.session(master=SPARK_MASTER,
                               sparkConfig=list(spark.driver.memory="2g",
                                                spark.driver.extraClassPath=SPARKSHARK_JAR,
                                                spark.driver.extraLibraryPath="SPARKSHARK_JAR",
                                                spark.driver.extraJavaOptions=JAVA_OPTIONS),
                               sparkJars=SPARKSHARK_JAR)
mongoDBUtils <- rShark.createMongoDBUtils(sparkSession)
```

Example 2: Initialize a remote Spark session and a MongoDB with authentication
-----------------------------------------------------------------------------------
```R
SPARK_MASTER <- spark://YOURHOST:YOURPORT
SPARKSHARK_JAR <- "/users/jsmith/jars/sparkSHARK.jar"
JAVA_OPTIONS <- paste("-Dspark.exectutorEnv.dbtuils.type=mongo",
                      "-Dspark.executorEnv.mongo.uri=http://somehost/",
                      "-Dspark.executorEnv.mongo.port=27017",
                      "-Dspark.executorEnv.mongo.dbname=smartshark",
                      "-Dspark.executorEnv.mongo.useauth=true",
                      "-Dspark.executorEnv.mongo.username=USER",
                      "-Dspark.executorEnv.mongo.authdb=admin",
                      "-Dspark.executorEnv.mongo.password=PASSWORD")

sparkSession <- sparkR.session(master=SPARK_MASTER,
                               sparkConfig=list(spark.driver.memory="2g",
                                                spark.driver.extraClassPath=SPARKSHARK_JAR,
                                                spark.driver.extraLibraryPath="SPARKSHARK_JAR",
                                                spark.driver.extraJavaOptions=JAVA_OPTIONS),
                               sparkJars=SPARKSHARK_JAR)
mongoDBUtils <- rShark.createMongoDBUtils(sparkSession)
```

Example 3: Loading data
-----------------------
```R
# Load all data from the commit collection
rShark.loadData(mongoDBUtils, "commit")

# Loads the document ID and the product metrics available for Java classes
# from the entity_state collection
rShark.loadDataLogical(mongoDBUtils,
                       "entity_state",
                       list(c("id"), c("PRODUCT_METRIC", "JAVA_CLASS")))
```

