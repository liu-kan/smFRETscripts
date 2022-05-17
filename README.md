# smFRETscripts

## Overview
* burstSearchBin.r is a R script help you group smFRET bin data by burst.
* fretFit contains matlab/octave scripts to analyze smFRET data.

    SMFRET data was analyzed by using the expectation-maximization (EM) algorithm for fitting multi-Gaussian mixture models. First, the program makes a hypothesis about the number of different components that make up the observed smFRET data and then it calculates the likelihood for the corresponding parameters, and finally the program adjusts the parameters to maximize the likelihood. For evaluating the number of Gaussian components, we introduced Bayesian information criterion (BIC) and Akaike information criterion (AIC) terms, in addition to an overall correlation coefficient, R2. The errors associated with Gaussian species were obtained from triplicate experiments. A bootstrap resampling method was also used to estimate the errors, which are generally smaller (<1%). 

## License and Copyrights
If you feel this software help your research, you can cite this work as "Kan Liu. (2015-2022). liu-kan/smFRETscripts. Zenodo. https:/doi.org/10.5281/zenodo.6557345"

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.6557345.svg)](https://doi.org/10.5281/zenodo.6557345)