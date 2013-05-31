#!/bin/sh
# make_kernel_patch.sh, save add/changed files patch dir
#    run command "git status" to get the changed files
cd `dirname $0`
TOP_DIR=`pwd`/../
TMP_PATCH_DIR=`pwd`/../kernel_patch_tmp/patch/linux-sunxi/
changes=`git status -s | grep " M " | cut -b 4-`
adds=`git status -s | grep "?? " | cut -d ' ' -f2`
rm -rf ${TMP_PATCH_DIR}/
mkdir -p ${TMP_PATCH_DIR}/

for i in $changes
do
	if [ -f $i ]; then
		echo "copy $i"
		dest=${TMP_PATCH_DIR}/`dirname $i`
		mkdir -p $dest &&
		cp $i $dest
	fi
done

for i in $adds
do
	if [ -d $i ]; then
		echo "add dir $i"
		dest=${TMP_PATCH_DIR}/`dirname $i`
		mkdir -p $dest &&
		cp $i $dest -ar
	elif [ -f $i ]; then
		echo "add file $i"
		dest=${TMP_PATCH_DIR}/`dirname $i`
		mkdir -p $dest &&
		cp $i $dest
	fi
done

cd $TMP_PATCH_DIR/
find ./ -name "*.cmd" | xargs rm -rf
find ./ -name "*.mod.c" | xargs rm -rf
find ./ -name "*.ko" | xargs rm -rf
find ./ -name "modules.builtin" | xargs rm -rf
find ./ -name "modules.order" | xargs rm -rf

cd $TMP_PATCH_DIR/../../
tar zcf patch.tgz ./patch
tar zxf patch.tgz -C $TOP_DIR
rm  -rf ${TOP_DIR}/kernel_patch_tmp/
echo "generated kernel patch to $TOP_DIR/patch/linux-sunxi"
