import os
import subprocess
import pandas as pd
from concurrent.futures import ProcessPoolExecutor, as_completed


def execute_command(command, output_dir):
    try:
        process = subprocess.Popen(
            command, stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        stdout, stderr = process.communicate()
        if process.returncode != 0:
            print(f"Command execution failed: {command}")
            print(f"Error message: {stderr.decode()}")
        else:
            print(f"Command executed successfully: {command}")
            print(f"Output: {stdout.decode()}")
    except Exception as e:
        print(f"Exception occurred while executing command: {e}")


def main():
    distribution = ["crd", "dirichelt", "uniform"]
    target_dir = "your_target_dir"  # Replace with the actual target directory
    c_values = [1, 5, 10, 15]

    for dis in distribution:
        input_dir = f"{target_dir}/mix"
        output_base_dir = f"~/{dis}_dis/"
        matrix_file = f"~/{dis}_dis/{dis}_matrix.csv"

        # Get the sorted list of files
        file_list = sorted(
            [f for f in os.listdir(input_dir) if f.endswith(".hg38.pat.gz")]
        )

        # Read the {dis}_matrix.csv file
        df = pd.read_csv(matrix_file)

        # Get the number of columns
        num_columns = df.shape[1]

        # Create a process pool with a maximum concurrency of 10
        with ProcessPoolExecutor(max_workers=10) as executor:
            futures = []

            # Loop to execute commands
            for c in c_values:
                output_dir = os.path.join(output_base_dir, f"{dis}_{c}")
                os.makedirs(output_dir, exist_ok=True)  # Create the output directory

                for i in range(num_columns - 1):
                    column_data = (
                        df.iloc[:, i + 1].astype(str).tolist()
                    )  # Convert to a list of strings
                    dis_param = f"{dis}_{i:02d}"  # Format dis_param

                    mix_pat_cmd = [
                        "wgbstools",
                        "mix_pat",
                        *[os.path.join(input_dir, f) for f in file_list],
                        "--rates",
                        *column_data,
                        "-p",
                        os.path.join(output_dir, dis_param),
                        "--genome",
                        "hg38",
                        "-f",
                        "--threads",
                        "9",
                        "-c",
                        str(c),
                    ]
                    print("Submitting command:", mix_pat_cmd)

                    # Set OpenBLAS thread count to 2
                    os.environ["OMP_NUM_THREADS"] = "2"
                    os.environ["OPENBLAS_NUM_THREADS"] = "2"

                    # Submit the task to the process pool
                    future = executor.submit(execute_command, mix_pat_cmd, output_dir)
                    futures.append(future)

            # Wait for all tasks to complete
            for future in as_completed(futures):
                try:
                    future.result()
                except Exception as e:
                    print(f"Task execution failed: {e}")


if __name__ == "__main__":
    main()
