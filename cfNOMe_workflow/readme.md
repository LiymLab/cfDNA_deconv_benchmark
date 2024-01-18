Since the reference methylation atlas used by cfNOMe is consistent with MethAtlas, the primary operation involves converting files utilized in MethAtlas to a format supported by cfNOMe. For more detailed information and assistance, please refer to the content available at https://github.com/FlorianErger/cfNOMe.

The deconvolution process can be executed by specifying the appropriate arguments when running the Python script 'run_deconv.py'. To do this, use the following command line options: --input-dir {mixture_dir}, --ref-file {path_to_ref_bed}, and --dis {uniform or crd}.

Before executing the deconvolution, it's advisable to modify the location of cfNOMe within the 'run_deconv.py' file to avoid any potential errors. This ensures that the program correctly references the cfNOMe installation and runs without issues.
