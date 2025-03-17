## Analyzing brain connectivity in Attention Deficit Hyperactivity Disorder (ADHD) using frequency domain covariance estimation techniques

### Introduction

This page includes data and functions associated with the paper "Analyzing brain connectivity in Attention Deficit Hyperactivity Disorder (ADHD) using frequency domain covariance estimation techniques". 

#### Data

`0010020_roi_aal_mask_pad.csv` is a rs-fMRI dataset for an adhd patient from the ADHD-200 Sample repository. For more information about this repository, please visit [ADHD-200 Preprocessed](preprocessed-connectomes-project.org/adhd200/).

#### Functions

`fdft` is a function to calculate discrete fourier transform (DFT).

`frea` is a function to extract the real part of DFT under each frequency.

`f_para_boot` is a function to conduct parametric bootstrap.

`f_all` is a function to wrap up the above three functions.
