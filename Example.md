## Introduction

In this section, we will show you how to use our functions to calculate the number of edge for certain combination of frequencies and networks. 

### Data

The data we will use is `0010020_roi_aal_mask_pad.csv`, which is a rs-fMRI dataset for an adhd patient from the ADHD-200 Sample repository. For more information about this repository, please visit [ADHD-200 Preprocessed](preprocessed-connectomes-project.org/adhd200/).

### Functions

Here we will use four functions, `fdft`, `freal`, `f_para_boot`, and `f_all`.

Below are all the arguments in `fdft`. `x` is a time series vector and `w` is a specific frequency.

```{}
fdft(x, w)
```

Below are the arguments in `freal`. `data` is a weakly stationary time series matrix and `w` is a specific frequency.

```{}
freal(data, w)
```

Below are the three arguments in `f_para_boot`. `x` is the real part (a matrix) of spectral density. `alpha` is the significance level. `B` is the number of iterations.

```{}
f_para_boot(x, alpha, B)
```

Below are all the arguments in `f_all`. `x` is the standardized time series matrix. `y` is the length of a frequency vector. `alpha` is the significance level.

```{}
f_all(x, y, alpha)
```

### Application
