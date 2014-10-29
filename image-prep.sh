#!/usr/bin/env bash

DOWNLOADDIR=images/download
OVADIR=images/fixedova
FIXESDIR=fixes
VMXDIR=images/vmx
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
OVAPREFIX=space
VERSIONS="13.3R4.4
14.1R1.9
"

for v in $VERSIONS

do
    if test -f $DOWNLOADDIR/$OVAPREFIX-$v.ova;
    then
        echo -e "\n\n\033[32mProcessing $v:\033[0m";
        echo -e "\n\033[32mOpening $v:\033[0m";
        tar xvf $DOWNLOADDIR/$OVAPREFIX-$v.ova -C $OVADIR/$v;
        echo -e "\n\033[32m[vmware-vmx]: Creating thin-provisioned 100GB disk for $v:\033[0m";
        $VDISKMANAGER $VDM_FLAGS $VMXDIR/$v/$OVAPREFIX-$v-disk2.vmdk;
        echo -e "\n\033[32mPatching $v ovf:\033[0m";
        cp -v $FIXESDIR/$OVAPREFIX-$v.vmx $OVADIR/$v/;
        echo -e "\n\033[32m[vmware-vmx]: ovftool install .VMX: $VMXDIR/$v:\033[0m";
        $OVFTOOL $OVFTOOL_FLAGS $OVADIR/$v/$OVAPREFIX-$v.ovf $VMXDIR/$v/$OVAPREFIX-$v.vmx;
        # echo -e "\n\033[32m[virtualbox-ovf]: Re-packaging .OVA $v:\033[0m";
        # $OVFTOOL $OVFTOOL_FLAGS $OVADIR/$v/$OVAPREFIX-$v.ovf $OVADIR/$OVAPREFIX-$v.ova;
    fi
done
