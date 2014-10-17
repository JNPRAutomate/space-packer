# [space-packer](http://github.com/JNPRAutomate/space-packer)
[![Build Status](https://travis-ci.org/JNPRAutomate/space-packer.svg)](https://travis-ci.org/JNPRAutomate/space-packer)

Packer templates for building the [Junos Space Network Management Platform](http://www.juniper.net/us/en/products-services/network-management/), as well as its components:
- [Security Director](http://www.juniper.net/us/en/products-services/security/security-director/index.page?)
- [Virtual Director](http://www.juniper.net/us/en/products-services/network-management/junos-space-applications/virtual-director/)
- [Log Director / Security Director Logging and Reporting](http://www.juniper.net/techpubs/en_US/junos-space13.3/information-products/topic-collections/junos-space-security-designer/security-director-logging-reporting-getting-started-guide.pdf)

> ___PROTIP___: these are experimental versions, and it's recommended that you use the prebuilt Vagrant labs when they are available.

## Usage

Please see the [Packer documentation](http://www.packer.io/docs) if you plan on building these images yourself!

 1. Install Packer 0.7.2 (not currently released), or build/install with [pull request 1497](https://github.com/mitchellh/packer/pull/1497).
 2. Clone this repo, e.g. `git clone https://github.com/JNPRAutomate/space-packer`
 3. Procure Space VM images, and place in `./images/download` in the project directory
 4. Run the `image-prep.sh` script to prepare the images.  Ideally, this will also download the source .OVA files in the future.
 4. Modify the templates for your environment, if desired
 5. It's time to watch Packer work its magic:
  - `packer validate <templatename>` will validate the JSON templates provided.  If any of the source VMs, files, scripts, or automation inputs are missing, `validate` will tell you which ones (in addition to JSON syntax checking)
  - `packer build <templatename>` will build the VMs for VMware and VirtualBox.  You need both installed, or you need to specify `-only <provider>`, e.g. `-only=virtualbox-ovf`, or `-only=vmware-vmx`
  - The finished VM boxes will be placed in `./builds/<provider>`


## Notes

These boxes are designed to work in a lab environment with static IPs, and it's recommended that you change settings in these templates for your environment.

## Issues

Please open any issues on the [space-packer github issue tracker](https://github.com/JNPRAutomate/space-packer/issues).  Please make sure you've checked out the common issues before opening a ticket.
