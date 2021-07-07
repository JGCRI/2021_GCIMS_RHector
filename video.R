# Script recorded for the GCIMS R Hector demo video series

## Set Up #######################################################
# Install the packages that will be used in the workshop, they only need to be installed
# once. 
#install.packages("remotes")
#install.packages("ggplot2")

# Load the packages 
library("remotes")
library("ggplot2")

# Use install_github (a remotes) function to download, install, and compile 
# R hector from github. This will only need to be done once. 
#install_github("JGCRI/hector")

# Load the hector pacakges.
library("hector")

## Example: Run RCP45 #######################################################
# List all of the ini files that are included in the Hector package. 
list.files(system.file("input", package = "hector"))

# Select an ini file to use to set up a hector core. 
ini_file = system.file("input/hector_rcp45.ini", package = "hector")
ini_file

# Set up a hector core with the ini file. 
hcore = newcore(inifile = ini_file, name = "default rcp45")
hcore

# Run hector! 
run(core = hcore)
hcore

# Query the results 
dates = 1850:2100 # define the dates of data we want
dates

var = GLOBAL_TEMP() # define the variable/s we want to look at. 
var

data1 = fetchvars(core = hcore, dates = dates, var = var) 
data1

# plot the data 
ggplot(data = data1) + 
  geom_line(aes(year, value, color = scenario)) + 
  labs(title = "Hector Global Mean Temp", 
       y = "deg C")

# Shut down the core. 
shutdown(core = hcore)
hcore


## Example: Change a parameter  #######################################################
ini_file = system.file("input/hector_rcp45.ini", package = "hector")
ini_file

hcore = newcore(inifile = ini_file, name = "ECS x 2 rcp45")
hcore

default_ECS = fetchvars(hcore, dates = NA, vars = ECS())
default_ECS

doubble_ECS = default_ECS$value * 2
doubble_ECS

ECS_units = getunits(ECS())
ECS_units

setvar(core = hcore, dates = NA, var = ECS(), values = doubble_ECS, 
       unit = ECS_units)
hcore

run(hcore)

data2 = fetchvars(core = hcore, dates = dates, vars = GLOBAL_TEMP())
data2

single_df = rbind(data1, data2)

ggplot(data = single_df) + 
  geom_line(aes(year, value, color = scenario)) + 
  labs(title = "Hector Global Mean Temp", 
       y = "deg C")


## R Documentation  #######################################################
help("hector")
help("ECS")
