{self, inputs, ... }: {

  flake.nixosModules.pcHardware = { config, lib, pkgs, modulesPath, ... }:
	{
	  imports =
	    [ (modulesPath + "/installer/scan/not-detected.nix")
	    ];

	  boot.initrd.availableKernelModules = [ "nvme" "ahci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
	  boot.initrd.kernelModules = [ ];
	  boot.kernelModules = [ "kvm-amd" ];
	  boot.extraModulePackages = [ ];

	  fileSystems."/" =
	    { device = "/dev/mapper/luks-d6c70d84-13be-4edf-9f3b-b8006d4d13da";
	      fsType = "ext4";
	    };

	  boot.initrd.luks.devices."luks-d6c70d84-13be-4edf-9f3b-b8006d4d13da".device = "/dev/disk/by-uuid/d6c70d84-13be-4edf-9f3b-b8006d4d13da";

	  fileSystems."/boot" =
	    { device = "/dev/disk/by-uuid/9513-5E34";
	      fsType = "vfat";
	      options = [ "fmask=0077" "dmask=0077" ];
	    };

	  fileSystems."/home" =
	    { device = "/dev/mapper/luks-25339d97-502e-4e4e-9aeb-c7179b1d429b";
	      fsType = "ext4";
	    };

	  boot.initrd.luks.devices."luks-25339d97-502e-4e4e-9aeb-c7179b1d429b".device = "/dev/disk/by-uuid/25339d97-502e-4e4e-9aeb-c7179b1d429b";

	  swapDevices =
	    [ { device = "/dev/disk/by-uuid/d0b784f6-26dc-4351-95b8-abab3989cb09"; }
	    ];

	  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
	};
}
