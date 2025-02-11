{ pkgs, ... }:
{
  # Backend to use for PyTorch.
  # - null: No backend. Disables Python environment auto activation.
  # - "cuda": CUDA backend.
  # - "rocm": ROCm backend.
  # - "cpu": CPU backend.
  torch.backend = "rocm";
  # Extra driver path.
  torch.driverPkg = null;
  # Example for speqcifying a custom NVIDIA driver.
  /*
    torch.driverPkg = (pkgs.linuxPackages.nvidiaPackages.mkDriver {
        version = "560.35.03";
        sha256_64bit = "sha256-8pMskvrdQ8WyNBvkU/xPc/CtcYXCa7ekP73oGuKfH+M=";
        #    settingsSha256 = "";
        useSettings = false;
        usePersistenced = false;
      }).override
        {
          libsOnly = true;
          kernel = null;
        };
  */
}
