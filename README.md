# Install Hyper-V on Windows 10, and create an Ubuntu virtual machine

## Install Hyper-V on Windows 10
There are many ways to install Hyper-V on Windows 10, the way we describe here is a simple activation by PowerShell command line, without any source image.
Hyper-V is built into Windows as an optional feature -- there is no Hyper-V download.

### Prerequisites
   * Windows 10 Enterprise, Pro, or Education
   * 64-bit Processor with Second Level Address Translation (SLAT).
   * CPU support for VM Monitor Mode Extension (VT-c on Intel CPUs).
   * Minimum of 4 GB memory.

### Enable Hyper-V using PowerShell
1. Open a PowerShell console as Administrator.
2. Run the following command line
```
$ Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

## Create an Ubuntu virtual machine
1. Open Hyper-V Quick Create from the start menu (Windows button).
   ![alt](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/media/quick-create-start-menu.png)
   
2. Select an operating system or choose your own by using a local installation source.
   ![alt](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/media/vmgallery.png)

3. Select the option `Create Virtual Machine`.
   
The Quick Create tool will take care of the rest.

4. In your ubuntu virtual machine, open a terminal and run the command
```
$ sudo snap install docker
```

## Sources
https://docs.microsoft.com/fr-fr/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v