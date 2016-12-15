# rSHARK
R library for using SmartSHARK
## Install
### via RStudio
You need to load SparkR [SparkR](https://github.com/apache/spark/tree/master/R) package first.Set Enviroment variable SPARK_HOME and load the SparkR libarary. In R Studio you can run [SparkRDoc](http://spark.apache.org/docs/latest/sparkr.html)

    if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
      Sys.setenv(SPARK_HOME = SPARK_PATH)
    }
    library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
After installing and loading SparkR you can install rSHARK package.In RStudio you can run:

    install_github("smartshark/rSHARK")
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


 
