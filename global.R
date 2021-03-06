library(RMySQL)

my_data <- read.csv("credentials.csv", header=TRUE,sep=",", colClasses=c("character","character","character","character"))
# print(my_data[1, "host"])

lapply( dbListConnections( dbDriver( drv = "MySQL")), dbDisconnect)


mydb = dbConnect(MySQL(),
                 user=my_data[1, "username"],
                 # rstudioapi::askForPassword("Database user"),
                 password=my_data[1, "password"],
                 # rstudioapi::askForPassword("Database password"),
                 dbname=my_data[1, "dbname"],
                 host=my_data[1, "host"])



FetchDatas <- function(conditionLists = list(), option = "*")
{
  queryString = GenerateQuery(conditionLists, option)
  # print(dbGetQuery(mydb, queryString))
  return(dbGetQuery(mydb, queryString))
}


GenerateQuery <- function(conditionLists, option)
{
  queryString = paste("SELECT", option, sep = " ")
  queryString = paste(queryString, "FROM tunnel_fit_test", sep = " ")
  
  if (length(conditionLists) == 0)
  {
    # print(queryString)
    return(queryString)
  }
  
  conditionLink = "OR"
  listLink = "AND"
  
  queryString = paste(queryString, "WHERE", sep = " ")
  
  for (i in 1:length(conditionLists)){
    queryString = paste(queryString, "(", sep = "")
    for (j in 1:length(conditionLists[[i]])){
      queryString = paste(queryString, conditionLists[[i]][[j]], sep = " ")
      if (j < length(conditionLists[[i]]))
      {
        queryString = paste(queryString, conditionLink, sep = " ")
      }
    }
    queryString = paste(queryString, ")", sep = "")
    if (i < length(conditionLists))
    {
      queryString = paste(queryString, listLink, sep = " ")
    }
  }
  # print(queryString)
  return(queryString)
}


GetField <- function(fieldName, fetchResult)
{
  return(fetchResult[[fieldName]])
}


CountField <- function(fieldName = "*", conditions = list())
{
  tempField <- paste("COUNT(DISTINCT ", fieldName, sep = "")
  tempField <- paste(tempField, ")", sep = "")
  return(GetField(tempField, FetchDatas(conditions, tempField)))
}


GenerateSelectChoices <- function(default = "", text = "", fieldName, conditions = list(), extraInfo = list())
{
  tempList <- list()
  tempList[[default]] <- -1
  fieldList <- GetField(fieldName, FetchDatas(conditions, paste("DISTINCT", fieldName)))
  extraTextString = ""
  
  if(length(fieldList) == 0)
    return(tempList)
  
  for(i in 1:length(fieldList))
  {
    if(length(extraInfo) != 0)
    {
      extraTextString = ""
      extraText <- list()
      for(j in 1:length(extraInfo))
      {
        # print(j)
        tempContitions <- conditions
        tempContitions[[length(tempContitions) + 1]] <- paste(toString(fieldName), " = ", fieldList[[i]], sep = "")
        extraText[[j]] <- GetField(extraInfo[[j]], FetchDatas(tempContitions, paste("DISTINCT", extraInfo[[j]])))[[1]]
        # print(extraText)
      }
      
      
      for(j in 1:length(extraText))
      {
        extraTextString <- paste(extraTextString, toString(extraText[[j]]), sep = "")
      }
    }
    
    resultString <- ""
    
    if (is.numeric(fieldList[[i]]))
    {
      resultString <- paste(text, fieldList[[i]], sep = " ")
    }
    else
    {
      resultString <- fieldList[[i]]
    }
    
    if(extraTextString != "")
    {
      extraTextString <- paste("(", extraTextString, ")", sep = "")
      resultString <- paste(resultString, extraTextString, sep = " ")
    }
    
    tempList[[resultString]] <- fieldList[[i]]
  }
  return(tempList)
}

getData = function(gametype = "Tunnel", param = "TargetsDistanceInches", slidermin = 0, slidermax = 2) {
  print(param)
  return(
    FetchDatas(conditionLists = list(list(paste('GameType = "', gametype, '"', sep = '')),
                                     list(paste("DeltaTime >= ", slidermin, sep = "")), 
                                     list(paste("DeltaTime <= ", slidermax, sep = ""))),
               option = paste('DeltaTime, ', param, sep = '')
    )
  )
  
  
}


