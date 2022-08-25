# Species-Distribution-Modeling
This repository contains all the files, code and workflow required for the performance of Ecological niche modeling using MaxEntg

The first step is to download MaxEnt sofware, which is open source sofware used for modeling species niches and distributions by applying a techniue called moaximum entropy modeling. From a set of environmental variables and occurrence records of the species, one can predict the probability of disctribution of species in the area of interest. 
The following are the steps to be follwed to perform SDM with the software Maxent. 

1) The first step is to download occurrence records from the website, Global Biodiversity Information Facility (GBIF). The link to the website: https://www.gbif.org/. For example, for our study, we used the three species of Artocarpus; Artocarpus heterophyllus, Artocarpus hirsutus and Artocarpus altilis. The occurrence records were taken for the following coordinates for all the three species, in the sequence of (N, S, E, W);

      Artocarpus heterophyllus: (36, 6, 96, 70)
      Artocarpus hirsutus: (36, 6, 96, 70)
      Artocarpus altilis: (5, -15, 170, 120)

2) The next step is to download environmental variables for different time periods. Bioclim (https://www.worldclim.org/data/bioclim.html) has bioclimatic variables for different time periods, historical, paleoclimatic, future and present. For paleoclimatic environmental varibles, one can also look at the Paleoclim website (http://www.paleoclim.org/), which has bioclimatic variables for different Pleistocene and Pliocene time periods. For our study to predict distribution of each species, we downloaded the paleoclimate data for three time periods: Last glacial maximum (ca. 21 ka), Last interglacial (ca. 130 ka) and MIS19 (ca. 787 ka) with a  spatial resolution of 2.5 arc-minutes (~5 km). 

3) 
