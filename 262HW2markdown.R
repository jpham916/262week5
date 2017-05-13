---
title: "ESM262HW2markdown"
author: "jpham916"
date: "May 13, 2017"
output: html_document
---

  
```{r}
{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

library(tidyverse)
install.packages("tidyverse")
library(tibble)
  `````
 
###Read table without | limiters###

``` {r}
  gaz_raw <- read.delim("C:\\Users\\Jonathan Pham\\Desktop\\ESM 262 Computing\\262week5\\CA_Features_20170401.txt", sep = "|")
gaztib <- as.tibble(gaz_raw)
gaztib

```

###Subset Data 

```{r}
gazsubset <- gaztib[, c("ï..FEATURE_ID", "FEATURE_NAME","FEATURE_CLASS","STATE_ALPHA", "COUNTY_NAME","PRIM_LAT_DEC","PRIM_LONG_DEC","SOURCE_LAT_DEC","SOURCE_LONG_DEC","ELEV_IN_M","MAP_NAME","DATE_CREATED","DATE_EDITED")]

gazsubset
```


```{r}
####Now reclassifying each variable into appropriate format

#Change these to characters
gazsubset$ï..FEATURE_ID = as.character(gazsubset$ï..FEATURE_ID)
gazsubset$FEATURE_NAME = as.character(gazsubset$FEATURE_NAME)
gazsubset$FEATURE_CLASS = as.character(gazsubset$FEATURE_CLASS)
gazsubset$STATE_ALPHA = as.character(gazsubset$STATE_ALPHA)
gazsubset$COUNTY_NAME = as.character(gazsubset$COUNTY_NAME)
gazsubset$MAP_NAME = as.character(gazsubset$MAP_NAME)

#Changing dates from factors to date
gazsubset$DATE_CREATED = as.Date(gazsubset$DATE_CREATED, "%m/%d/%Y")
gazsubset$DATE_EDITED = as.Date(gazsubset$DATE_EDITED, "%m/%d/%Y")

gazsubset
```


```{r}
which(is.na(gazsubset$FEATURE_NAME))
which(is.na(gazsubset$FEATURE_CLASS))
which(is.na(gazsubset$STATE_ALPHA))
which(is.na(gazsubset$COUNTY_NAME))
which(is.na(gazsubset$MAP_NAME))


CAgaz <- gazsubset[(gazsubset$STATE_ALPHA = "CA" + gazsubset$PRIM_LAT_DEC = "!na")]

CAgaz
```

```{r}
write_delim(CAgaz,"CAGAZGAZ",delim="|", colnames= TRUE)
````

```{r}
names(which.max(table(CAgaz$FEATURE_NAME)))
#Church of Christ
(which.max(table(CAgaz$FEATURE_NAME)))
#16470
names(which.min(table(CAgaz$FEATURE_CLASS)))
#Isthmus
(which.min(table(CAgaz$FEATURE_CLASS)))
#33
````

````{r}
#To find centers of county
countycenters <- group_by(CAgaz, COUNTY_NAME)%>%
  summarize(CenterLat = (max(PRIM_LAT_DEC,na.rm = TRUE)+min(PRIM_LAT_DEC,na.rm = TRUE))/2, CenterLong = (max(PRIM_LONG_DEC, na.rm = TRUE)+min(PRIM_LONG_DEC,na.rm=TRUE))/2)


numCounties <- nrow(countycenters)-1
counties <- countycenters[1:numCounties,]

````