#!/usr/bin/env bash

DOWNLOAD_DIR=images/space/download
OVA_DIR=images/space/fixedova
FIXES_DIR=fixes
VMX_DIR=images/space/vmx
# OSX OVFTOOL is in /Applications/VMware\ OVF\ Tool/ovftool
# ... or another /Applications folder inside VMware Fusion
#
# Linux ovftool should be in /usr/bin on Workstation 10.X
OVFTOOL=ovftool
# VMware vdiskmanager should also be available with newer
# versions - when in doubt, go Pro!
# t6 = thin-provisioned 100G disk
VDISKMANAGER=vmware-vdiskmanager
VDM_FLAGS="-c -a lsilogic -s 100GB -t0"
# --lax is needed for 8,192MB source VM import
OVFTOOL_FLAGS="--overwrite --acceptAllEulas --lax"
OVA_PREFIX=space-
VERSIONS="13.3R2.6
"

for v in $VERSIONS

do
    if test -f $DOWNLOAD_DIR/$OVA_PREFIX$v.ova;
    then
        echo -e "\n\n\033[32mProcessing $v:\033[0m";
        echo -e "\n\033[32mOpening $v:\033[0m";
        tar xvf $DOWNLOAD_DIR/$OVA_PREFIX$v.ova -C $OVA_DIR/$v;
        echo -e "\n\033[32m[vmware-vmx]: Creating thin-provisioned 100GB disk for $v:\033[0m";
        $VDISKMANAGER $VDM_FLAGS $VMX_DIR/$v/$v-disk2.vmdk;
        # echo -e "\n\033[32mPatching $v ovf:\033[0m";
        # cp $FIXES_DIR/$OVA_PREFIX$v* $OVA_DIR/$v;
        echo -e "\n\033[32m[vmware-vmx]: ovftool install .VMX: $VMXDIR/$v:\033[0m";
        $OVFTOOL $OVFTOOL_FLAGS $OVA_DIR/$v/$OVA_PREFIX$v.ovf $VMX_DIR/$v/$OVF_PREFIX$v.vmx;
        echo -e "\n\033[32m[vmware-vmx]: patching .VMX for second disk $v:\033[0m";
        cp -v $FIXES_DIR/$v.vmx $VMX_DIR/$v/;
        # echo -e "\n\033[32m[virtualbox-ovf]: ovftool repackage to .OVA: $v:\033[0m";
        # $OVFTOOL $OVFTOOL_FLAGS $OVA_DIR/$v/$OVA_PREFIX$v.ovf $OVA_DIR/$OVA_PREFIX$v.ova;
    fi
done
