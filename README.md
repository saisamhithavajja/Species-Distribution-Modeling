# Species-Distribution-Modeling
This repository contains all the files, code and workflow required for the performance of Ecological niche modeling using MaxEnt (version 3.3.4).

The first step is to download MaxEnt sofware, which is open source sofware used for modeling species niches and distributions by applying a techniue called moaximum entropy modeling. From a set of environmental variables and occurrence records of the species, one can predict the probability of disctribution of species in the area of interest. 
The following are the steps to be follwed to perform SDM with the software Maxent. 

1) The first step is to download occurrence records from the website, Global Biodiversity Information Facility (GBIF). The link to the website: https://www.gbif.org/. For example, for our study, we used the three species of Artocarpus; Artocarpus heterophyllus, Artocarpus hirsutus and Artocarpus altilis. The occurrence records were taken for the following coordinates for all the three species, in the sequence of (N, S, E, W);

      Artocarpus heterophyllus: (36, 6, 96, 70)
      Artocarpus hirsutus: (36, 6, 96, 70)
      Artocarpus altilis: (5, -15, 170, 120)

2) The next step is to download environmental variables for different time periods. Bioclim (https://www.worldclim.org/data/bioclim.html) has bioclimatic variables for different time periods, historical, paleoclimatic, future and present. For paleoclimatic environmental varibles, one can also look at the Paleoclim website (http://www.paleoclim.org/), which has bioclimatic variables for different Pleistocene and Pliocene time periods. For our study to predict distribution of each species, we downloaded the paleoclimate data for three time periods: Last glacial maximum (ca. 21 ka), Last interglacial (ca. 130 ka) and MIS19 (ca. 787 ka) with a  spatial resolution of 2.5 arc-minutes (~5 km). 

3) The environmental layers are found in the format of BIL or TIFF files. These should be converted to ASCII files. For this, the open source software (QGIS Version 3.26.2) can be used. 

4) The environmental layers need to be resized according to the species study area. The coordinates used to resize are given below for the the three species used;

      Artocarpus heterophyllus: (36, 6, 96, 70)
      Artocarpus hirsutus: (36, 6, 96, 70)
      Artocarpus altilis: (5, -15, 170, 120)
      
5) After resizing, we can run the ENMevaluate on R studio. The code is given in the SDM R script. After the file, enemeval.csv is exported. Find the delta.AICc value 0, and the settings corresponding to it (L, LQ or LQP) will be the features one will select in MaxEnt. rm in the csv file represents, regularization multiplier, which is also set in the software MaxEnt. 

6) Open maxent.jar and set the following settings;

In samples; upload the occurrence records. In Environmental layers; add the bioclimatic layers in ASCII format.
Instead of Auto features, select the features from the ENMevaluate results. (For example, if the reulsts gave you delta.AICc value 0, for LQPTH, then you will select all the 5 featues, linear, quadratic, threshold, hinge and product. 
Check create response curves, do jackknife, select the output in cloglog form and select the output directory. 
Go to settings; in basic, check random seed, enter the regularization multiplier from the ENMevaluate results, background points from the R script and choose 10 replicates. In advanced; check write plot data. If you have a bias file, add it in the bias file section. In Experimental; check write background predictions. Everything else, should be default settings. 

7) Run the MaxEnt for species distribution modeling. 



