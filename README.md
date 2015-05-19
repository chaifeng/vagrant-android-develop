vagrant-android-develop
=======================

A Vagrant VM for Android development environment

## Requement

To install, download and install [Vagrant](https://www.vagrantup.com/) for your platform, then download and install [VirtualBox](https://www.virtualbox.org/).

## Quick start

``` console
curl -L https://bit.ly/vadqs | bash
```

## Manual

Clone and switch into this repository, update submodules

``` console
$ cd vagrant-android-develop
$ git submodule update --init --recursive
```

Run command `vagrant up` to start the VM

``` console
$ vagrant up
```

If you got any errors, destroy the VM and run again. 

``` console
$ vagrant destroy
$ vagrant up
```

Once everything completes, run the below command to build the WordPress for Android project

``` console
$ vagrant ssh -c 'cd src/WordPress-Android; gradle assembleVanilla'
```

### How to connect a Android Virtual Device?

Run *Genymotion* on your host, and start an Android VM. Then run `adb devices` on your host. Another way, you can find the IP of Android VM at the window title. (In most of cases, the first Android VM's IP address is *192.168.56.101*, and the second one's is *192.168.56.102*, etc.) Assume the IP address is *192.168.56.101*. Run the below command on Vagrant VM:

``` console
$ adb connect 192.168.56.101
```

### How to connect a Android phone?

First, use command `VBoxManage list usbhost` to find the *VendorId* of your Android phone.

``` console
$ VBoxManage list usbhost
Host USB Devices:

UUID:               d957abf9-18bf-46c6-a182-0466509d36de
VendorId:           0x04e8 (04E8)
ProductId:          0x6868 (6868)
Revision:           4.0 (0400)
Port:               1
USB version/speed:  0/2
Manufacturer:       SAMSUNG
Product:            SAMSUNG_Android
SerialNumber:       4df782582f0e405b
Address:            p=0x6868;v=0x04e8;s=0x0000608fbd70f37e;l=0x14100000
Current State:      Busy
```

Now we got the VendorId '*0x04e8*'. Set a system environment variable '*ANDROID_VENDOR_ID*' to this value, and reload the VM. Maybe you need to plug in your device again.

``` console
$ ANDROID_VENDOR_ID=0x04e8 vagrant reload
```

## What's inside?

 * Git
 * OpenJDK 7
 * Gradle 2.2.1
 * Maven 3.2.3
 * Ant 1.9.4
 * Apache httpd
 * PHP
 * MySQL
 * Ruby
 * RVM
 * Cucumber
 * Calabash
 * WordPress
 * WordPress Client for Android
 * Android SDK with packages:
   - tools
   - platform-tools
   - build-tools
   - android
   - extra-android-m2repository
   - extra-android-support
   - extra-google-m2repository

