# A versatile tool for simulating linear model data (simrel)

## Abstract

Data science is generating enormous amounts of data, and new and advanced analytical methods are constantly being developed to cope with the challenge of extracting information from such “big-data”. Researchers often use simulated data to assess and document the properties of these new methods. Here we present an R-package `simrel`, which is a versatile and transparent tool for simulating linear model data with an extensive range of adjustable properties. The method is based on the concept of relevant components and a reduction of the regression model. The concept was first implemented in an earlier version of `simrel` but only for single response case. In this version we introduce random rotations of latent components spanning a response space in order to obtain a multivariate response matrix Y. The properties of the linear relation between predictors and responses are defined by a small set of input parameters which allow versatile and adjustable simulations. In addition to the R-package, user-friendly shiny application with elaborate documentation and an RStudio gadget provide an easy interface for the package.

## Links

Presentation URL: https://goo.gl/9xDZqk
Shiny App URL: https://goo.gl/wYB38a

## Installation `simrel` R-package:

```r
if (!require(devtools)) install.packages("devtools")
devtools::install_github("simulatr/simrel")
```

## Run Shiny Application locally from GitHub:

```r
if (!require(simrel)) install.packages("simrel")
shiny::runGitHub("simulatr/AppSimulatr")
```
