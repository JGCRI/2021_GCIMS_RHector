# Run before demo if there are issues with internet connection, this is optional we will
# go through these steps in the video demo.

## Set Up #######################################################
# Install the packages that will be used in the workshop, they only need to be installed
# once. 
install.packages("remotes")
install.packages("ggplot2")

# Load the packages 
library("remotes")
library("ggplot2")

# Use install_github (a remotes) function to download, install, and compile 
# R hector from github. This will only need to be done once. 
install_github("JGCRI/hector")
