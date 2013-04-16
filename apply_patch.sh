#!/bin/sh
# apply_patch.sh
cd `dirname $0`
TOP=`pwd`
PATCH_DIR=${TOP}/patch
TMP_PATCH_PACKAGE=${TOP}/patch.tgz


echo "apply patch..."
sleep 1

cd $PATCH_DIR || echo "patch dir $PATCH_DIR not found" || exit 0
tar zcf $TMP_PATCH_PACKAGE ./ &&
tar xf $TMP_PATCH_PACKAGE -C ${TOP} 
rm -f $TMP_PATCH_PACKAGE 
