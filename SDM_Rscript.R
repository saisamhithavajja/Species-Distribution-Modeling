#R script for the Species Distribution Modeling
#The first step requires you to perform correlation analysis to see which of the biolimatic variables are important 
#This step will help us remove highly correlated data

#STEP 1
##Don't forget to set the working directory!

#these are the two packages required to perform this function
library(ENMTools)
library(ratster)

#after loading the pacakages, load the raster files 
bio1 <- raster("bio1.asc")
bio2 <- raster("bio2.asc")
bio3 <- raster("bio3.asc")
bio4 <- raster("bio4.asc")
bio5 <- raster("bio5.asc")
bio6 <- raster("bio6.asc")
bio7 <- raster("bio7.asc")
bio8 <- raster("bio8.asc")
bio9 <- raster("bio9.asc")
bio10 <- raster("bio10.asc")
bio11 <- raster("bio11.asc")
bio12 <- raster("bio12.asc")
bio13 <- raster("bio13.asc")
bio14 <- raster("bio14.asc")
bio15 <- raster("bio15.asc")
bio16 <- raster("bio16.asc")
bio17 <- raster("bio17.asc")
bio18 <- raster("bio18.asc")
bio19 <- raster("bio19.asc")

#after loading the raster files, stack the raster files
layers.stack <- raster::stack(bio1, bio2, bio3, bio4, bio5, bio6, bio7, bio8, bio9, bio10, bio11, bio12, bio13, bio14, bio15, bio16, bio17, bio18, bio19)

#this step will perform the correlation analysis
correlations <- raster.cor.matrix(layers.stack)

#once finished, export it into a csv file, where we can analyse and remove the highly correlated bioclimatic varibles
write.csv(correlations, "correlations.csv")


##STEP 2
#WITHOUT A BIAS FILE

#This next line of steps is to perfrom the ENMevaluate to run SDM in MaxEnt. This is a required step.
#This step will help us decide which settings one can use in MaxEnt to perform SDM

#these are the packages required to perform this step
library(devtools)
library(ENMeval)
library(raster)

#put here the names of your environmental layers, following the pattern below:
bio1 <- raster("bio1.asc")
bio2 <- raster("bio2.asc")
bio3 <- raster("bio3.asc")
bio15 <- raster("bio15.asc")
bio16 <- raster("bio16.asc")
bio17 <- raster("bio17.asc")
bio18 <- raster("bio18.asc")
bio19 <- raster("bio19.asc")

#Do what's called "stacking" the rasters together into a single r object
env <- stack(bio1, bio2, bio3, bio15, bio16, bio17, bio18, bio19)

#this next function will help you visualise the stacked r object that you created
env

#load in your occurrence points
occ <- read.csv("occ.csv")[,-1]

#check how many potential background points you have available
length(which(!is.na(values(subset(env, 1)))))

#If this number is far in excess of 10,000, then use 10,000 background points.
#If this number is comprable to, or smaller than 10,000, then use 5,000, 1,000, 500,
#or even 100 background points. The number of available non-NA spaces should 
#be well in excess of the number of background points used.

##This run uses the "randomkfold" method of cross-validation and 10 cross-validation folds. 

enmeval_results <- ENMevaluate(occ, env, bg = NULL, tune.args = list(fc = c("L","LQ","H", "LQH", "LQHP", "LQHPT"), rm = 1:5), partitions = "randomkfold", partition.settings = list(kfolds = 2), algorithm = "maxnet")
write.csv(enmeval_results@results, "enmeval_results1.csv")

#If there are categorical variables in your dataste, then you should include the follwing line of code:
#categoricals = c("biocateg1", "biocateg2")
#In general, be very careful that the categoricals argument points to the right variable(s).


#WITH A BIAS FILE
#If oy want to perform species distribution modelling using a bias file, tjhen you would
#run the follwing below code to create a bias file as well as, perform the ENMevaluate using
#the bias file

#continue this step after loading your occurence points
#make a bias file

occur.ras <- rasterize(occ, env, 1)

presences <- which(values(occur.ras) == 1)
pres.locs <- coordinates(occur.ras)[presences, ]

dens <- kde2d(pres.locs[,1], pres.locs[,2], n = c(nrow(occur.ras), ncol(occur.ras)), lims = c(extent(env)[1], extent(env)[2], extent(env)[3], extent(env)[4]))
dens.ras <- raster(dens, env)
dens.ras2 <- resample(dens.ras, env)

writeRaster(dens.ras2, "biasfile.asc", overwrite = TRUE)

#For the evalution below, we need to convert the bias object into another format.
#The code is set up to sample 10,000 background points. This is based on the code we ran
#earlier to see the potential number of background points.
#If we could change it to 5000 background points we would change the "10000" to "5000"

bg <- xyFromCell(dens.ras2, sample(which(!is.na(values(subset(env, 1)))), 10000, prob=values(dens.ras2)[!is.na(values(subset(env, 1)))]))
colnames(bg) <- colnames(occ)

##run the evaluation
##This run uses the "randomkfold" method of cross-validation, with a set of background points
##sampled based on the bias file, and 10 cross-validation folds. 

enmeval_results <- ENMevaluate(occ, env, bg, tune.args = list(fc = c("L","LQ","H", "LQH", "LQHP", "LQHPT"), rm = 1:5), partitions = "randomkfold", partition.settings = list(kfolds = 10), algorithm = "maxnet")
write.csv(enmeval_results@results, "enmeval_results1.csv")

#STEP 3

#This step will cell you count the population density in each grid cell

library(raster)

pop_count0 <- raster("Arthet_0.asc")
pop_count1 <- raster("Arthet_1.asc")
pop_count2 <- raster("Arthet_2.asc")
pop_count3 <- raster("Arthet_3.asc")
pop_count4 <- raster("Arthet_4.asc")
pop_count5 <- raster("Arthet_5.asc")
pop_count6 <- raster("Arthet_6.asc")
pop_count7 <- raster("Arthet_7.asc")
pop_count8 <- raster("Arthet_8.asc")
pop_count9 <- raster("Arthet_9.asc")


plot(pop_count8, axes = FALSE)
cellStats(pop_count8, 'sum')

#this is the end of the script