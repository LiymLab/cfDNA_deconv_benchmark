# cfNOMe Deconvolution Usage Guide

This guide aims to help you perform deconvolution analysis on files generated following our main workflow using the cfNOMe tool.

## Running the Deconvolution Process

For files produced through our primary workflow, you can execute the deconvolution process :

### Method : Run with Specified Parameters

Directly use the `methylation_deconvolution.py` script with the following parameters:

```bash
--ineq --verbose --ref_header True
```

Example command:

```bash
python methylation_deconvolution.py --ineq --verbose --ref_header True [other parameters]
```

## cfNOMe Usage Instructions

For detailed usage instructions and more features of the cfNOMe tool, please refer to the official GitHub repository:

- [cfNOMe Official Guide](https://github.com/FlorianErger/cfNOMe/tree/master)

## Required Deconvolution Script

The script required for deconvolution analysis is:

- [methylation_deconvolution.py](https://github.com/FlorianErger/cfNOMe/blob/master/methylation_deconvolution.py)

Please ensure you have downloaded this script and placed it in the correct directory to ensure proper execution.

---

If you have any questions during use, feel free to contact us.