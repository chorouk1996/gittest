# Install Hyper-V on Windows 10, create an Ubuntu virtual machine, and install Docker on it.

## Install Hyper-V on Windows 10
There are many ways to install Hyper-V on Windows 10, the way we describe here is a simple activation by PowerShell command line, without any source image.
Hyper-V is built into Windows as an optional feature -- there is no Hyper-V download.

### Prerequisites
   * Windows 10 Enterprise, Pro, or Education
   * 64-bit Processor with Second Level Address Translation (SLAT).
   * CPU support for VM Monitor Mode Extension (VT-c on Intel CPUs).
   * Minimum of 4 GB memory.

### Enable Hyper-V using PowerShell
1. Open a PowerShell console as **as Administrator**.
2. Run the following command line
```
$ Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

## Create an Ubuntu virtual machine
1. Open Hyper-V Quick Create from the start menu (Windows button).
   ![click here to view descriptive image](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/media/quick-create-start-menu.png)
   
2. Select unbutu for the operating system choice.
   ![click here to view descriptive image](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/media/vmgallery.png)

3. Click the button `Create Virtual Machine`.
   
   
The Quick Create tool will take care of the rest.
   

4. Click on the button `connect`, and fill your data in the form
   
5. The system will ask you to connect as user of your ubuntu virtual machine. Then enter your password and press `Enter`.
   
Your virtuall machine is ready for use.
   
## Install Docker on your ubuntu virtual machine

1. In your ubuntu virtual machine, press your right-click mouse button and select `open in terminal`
   

2. Run the following command in your terminal, and press `Enter`
```
$ sudo snap install docker
```
  
1. Enter your password, and press `Enter`
   

You are ready to use `Docker` on ubuntu.
   

## How to lunch your ubuntu virtual machine when your windows operating system is just started.

1. Press the windows's start button, type Hyper-V, and select `hyper-v manager`.
   

2. In the virtual machines list, double click on your ubuntu virtual machine 
   

3. Enter your password
   

Your ubuntu virtual machine is ready for use
  





## Sources
https://docs.microsoft.com/fr-fr/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v