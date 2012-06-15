#!/bin/bash

save_current_dir() {
	CURRENT_DIR=`pwd`
}

check_env() {
	if [ $COCOS2DX_ROOT"xxx" == "xxx" ]; then
		echo "pls set COCOS2DX_ROOT on your env"
		exit
	fi
	if [ $NDK_ROOT"xxx" == "xxx" ]; then
		echo "pls set NDK_ROOT on your env"
		exit
	fi
	if [ $ANDROID_SDK_ROOT"xxx" == "xxx" ]; then
		echo "pls set ANDROID_SDK_ROOT on your env"
		exit
	fi
}

copy_test_project() {
	rm -rf Resources
	cp -rif $COCOS2DX_ROOT/tests/Resources .
	rm -rf Classes
	mkdir Classes
	cp -rif $COCOS2DX_ROOT/tests/AppDelegate.* Classes
	cp -rif $COCOS2DX_ROOT/tests/tests Classes
}

update_android_makefile() {
	FILE=android/jni/Android.mk
	sed 's#.*LOCAL_WHOLE_STATIC_LIBRARIES.*#LOCAL_STATIC_LIBRARIES := curl_static_prebuilt\'$'\n''LOCAL_WHOLE_STATIC_LIBRARIES := cocos2dx_static cocosdenshion_static box2d_static chipmunk_static#' $FILE > $FILE.bak
	mv $FILE.bak $FILE

	sed 's#.*CocosDenshion/android.*#$(call import-module,CocosDenshion/android) $(call import-module,cocos2dx) $(call import-module,cocos2dx/platform/third_party/android/prebuilt/libcurl) $(call import-module,Box2D) $(call import-module,chipmunk)#' $FILE > $FILE.bak
	mv $FILE.bak $FILE
}

update_linux_makefile() {
	FILE=linux/Makefile
	sed 's#STATICLIBS*.#STATICLIBS = ${COCOS2DX_ROOT}/lib/linux/Debug/libbox2d.a ${COCOS2DX_ROOT}/lib/linux/Debug/libchipmunk.a ${COCOS2DX_ROOT}/cocos2dx/platform/third_party/linux/libraries/libcurl.a#' $FILE > $FILE.bak
	mv $FILE.bak $FILE
}

run_main() {
	save_current_dir
	check_env
	copy_test_project

	if [ ${PARAMS[0]} = "-android" ]; then
		update_android_makefile
	fi

	if [ ${PARAMS[0]} = "-linux" ]; then
		update_linux_makefile
	fi
}

PARAMS=$@

run_main
