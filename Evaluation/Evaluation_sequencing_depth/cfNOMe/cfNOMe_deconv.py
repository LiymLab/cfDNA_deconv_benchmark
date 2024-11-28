import argparse
import os
import subprocess


def run_methylation_deconvolution(input_dir, ref_file, dis):
    # Construct a list of command line arguments
    bed_files = [f"{input_dir}/{dis}_{i:02d}_1.bed" for i in range(100)]

    # Check if all BED files exist
    if not all(os.path.exists(bed) for bed in bed_files):
        raise FileNotFoundError(f"Not all BED files exist under the given directory.")

    cmd_args = [
        "python",
        "~/cfNOMe/methylation_deconvolution.py",  # Script files and execution commands can be found at https://github.com/FlorianErger/cfNOMe/tree/master.
        ref_file,
        *bed_files,
        "--ineq",
        "--verbose",
        "--ref_header",
        "True",
    ]

    # Construct the command line string
    cmd = " ".join(cmd_args)

    # Execute the shell command, capturing output and errors, and checking for successful execution
    completed_process = subprocess.run(cmd, shell=True, capture_output=True, check=True)
    if completed_process.returncode != 0:
        print(completed_process.stderr.decode())
        exit(1)


def main():
    parser = argparse.ArgumentParser(description="Deconvolute methylation data.")
    parser.add_argument(
        "--input-dir",
        type=str,
        required=True,
        help="The directory containing input mixture files.",
    )
    parser.add_argument(
        "--ref-file", type=str, required=True, help="The path to the reference file."
    )
    parser.add_argument(
        "--dis",
        type=str,
        required=True,
        choices=["uniform", "crd"],
        help="The distribution type (either uniform or crd).",
    )

    args = parser.parse_args()

    # Call the function using parsed arguments
    run_methylation_deconvolution(args.input_dir, args.ref_file, args.dis)


if __name__ == "__main__":
    main()
