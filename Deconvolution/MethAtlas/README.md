# MethAtlas Deconvolution Workflow

## Introduction

MethAtlas does not provide a workflow based on PAT/Beta files. To address this limitation, we have developed two scripts: [`ref_atlas_select.py`](https://github.com/LiymLab/cfDNA_deconv_benchmark/tree/main/Deconvolution/MethAtlas/ref_atlas_select.py) and [`gen_mixture.py`](https://github.com/LiymLab/cfDNA_deconv_benchmark/tree/main/Deconvolution/MethAtlas/gen_mixture.py). These scripts generate the necessary reference and sample files required by MethAtlas using Beta files.

Some versions of pandas may encounter exceptions during reading. In such cases, we recommend storing the contents of the `cpg_idx` column as an `int` type to resolve the issue.

A simple execution example is provided in the Jupyter notebook [`MethAtlas_deconv.ipynb`](https://github.com/LiymLab/cfDNA_deconv_benchmark/tree/main/Deconvolution/MethAtlas/MethAtlas_deconv.ipynb), which demonstrates how to use these scripts effectively.

## Usage

For detailed instructions on MethAtlas deconvolution, please refer to the [official MethAtlas repository](https://github.com/nloyfer/meth_atlas/tree/master). Below are the command-line options and an example of how to use the `deconvolve.py` script.

### Command-Line Options

```
usage: deconvolve.py [-h] [--atlas_path ATLAS_PATH] [--slim] [--plot]
                     [--out_dir OUT_DIR]
                     samples_path

positional arguments:
  samples_path            Path to the samples CSV file. It must have a header line.
                          The first column should be Illumina IDs (e.g., cg00000029).

optional arguments:
  -h, --help              Show this help message and exit.
  --atlas_path ATLAS_PATH, -a ATLAS_PATH
                          Path to the Atlas CSV file. The first column should be
                          Illumina IDs (e.g., cg00000029).
  --slim                  Output the results table without indexes and header line.
  --plot                  Display a stacked bar chart of the results.
  --out_dir OUT_DIR, -o OUT_DIR
                          Specify the output directory.
```

### Example

To perform deconvolution using a reference atlas and sample data, run the following command:

```bash
deconvolve.py -a reference_atlas.csv examples.csv
```

## Additional Resources

- **Scripts for Generating Reference and Sample Files**: Located in the `Deconvolution/MethAtlas/` directory.
  - [`ref_atlas_select.py`](https://github.com/LiymLab/cfDNA_deconv_benchmark/tree/main/Deconvolution/MethAtlas/ref_atlas_select.py)
  - [`gen_mixture.py`](https://github.com/LiymLab/cfDNA_deconv_benchmark/tree/main/Deconvolution/MethAtlas/gen_mixture.py)

- **Execution Example**: Refer to the Jupyter notebook [`MethAtlas_deconv.ipynb`](https://github.com/LiymLab/cfDNA_deconv_benchmark/tree/main/Deconvolution/MethAtlas/MethAtlas_deconv.ipynb) for a step-by-step guide.

- **MethAtlas Official Repository**: [https://github.com/nloyfer/meth_atlas/tree/master](https://github.com/nloyfer/meth_atlas/tree/master)

Feel free to explore the provided scripts and examples to integrate MethAtlas deconvolution into your methylation analysis workflow.