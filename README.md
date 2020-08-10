# A Prototype QSP Model of the Immune Response to SARS-COV-2 for Community Development

The model mechanistically accounts for the influence of key mediators relevant to COVID-19 pathophysiology including, interactions between viral dynamics, the major host immune response mediators, and alveolar tissue damage and regeneration.

## Prerequisites
MATLAB

This code was written in MATLAB 2019a

## Setup

Add all files in this repository to the MATLAB working directory.

## Contents
The repository should contain the following required files:

1. covid19_dxdt.m -> *model file with ODEs*
2. covidEventFcn.m
3. Driver.m
4. figuremods.m
5. function_run_model.m
6. function_run_model_noplots.m
7. generate_figures.m -> *generates manuscript figures*
8. get_data_dictionary.m
9. plot_vp.m
10. run_parameter_sweep.m
11. run_unit_test_script.m -> *runs unit tests in model*
12. run_VP.m
13. SolveBalances.m
14. vp_figure.m
15. Initialize.xlsx

## Usage
The command listed below generates figures of all the results in the manuscript and saves them as .png files.

```matlab
run generate_figures.m
```
## Authors
Wei Dai*, Rohit Rao*, Anna Sher, Nessy Tania, CJ Musante, Richard Allen**

\* Joint first authors  
\** Correspondence to: richard.allen@pfizer.com

![alt text](https://github.com/openPfizer/DigitalHealthData/blob/master/img/osbypfizer.png)
