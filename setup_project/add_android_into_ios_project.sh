#!/bin/bash

save_current_dir() {
	CURRENT_DIR=`pwd`
}

check_env() {
	if [ $COCOS2DX_ROOT"xxx" = "xxx" ]; then
		echo "pls set COCOS2DX_ROOT on your env"
		exit
	fi
	if [ $NDK_ROOT"xxx" = "xxx" ]; then
		echo "pls set NDK_ROOT on your env"
		exit
	fi
	if [ $ANDROID_SDK_ROOT"xxx" = "xxx" ]; then
		echo "pls set ANDROID_SDK_ROOT on your env"
		exit
	fi
}

create_android_project() {
	cd $COCOS2DX_ROOT
	sh create-android-project.sh
	cd $CURRENT_DIR
}

input_project_name() {
	echo "Input the project name:"
	read PROJECT_NAME
	COCOS2DX_PROJECT=$COCOS2DX_ROOT/$PROJECT_NAME
	CURRENT_PROJECT=$CURRENT_DIR
}

copy_project_to_current_dir() {
	rm -rf $CURRENT_PROJECT/android
	mv $COCOS2DX_PROJECT/android $CURRENT_PROJECT
	### remove the following command since CC2DX 0.13
	#rm $CURRENT_PROJECT/Classes/Android.mk
	#mv $COCOS2DX_PROJECT/Classes/Android.mk $CURRENT_PROJECT/Classes
	rm -rf $COCOS2DX_PROJECT
}

update_lib_reference() {
	rm -rf $CURRENT_PROJECT/libs
	mkdir $CURRENT_PROJECT/libs
	ln -s $COCOS2DX_ROOT/cocos2dx $CURRENT_PROJECT/libs/cocos2dx
	ln -s $COCOS2DX_ROOT/CocosDenshion $CURRENT_PROJECT/libs/CocosDenshion
	ln -s $COCOS2DX_ROOT/Box2D $CURRENT_PROJECT/libs/Box2D
}

update_build_native() {
	FILE=$CURRENT_PROJECT/android/build_native.sh

	sed '2s/.*//' $FILE > $FILE.bak
	mv $FILE.bak $FILE
	sed '3s/.*//' $FILE > $FILE.bak
	mv $FILE.bak $FILE
	sed '4s/.*/GAME_ROOT=..\//' $FILE > $FILE.bak
	mv $FILE.bak $FILE
	sed '5s/.*/GAME_ANDROID_ROOT=./' $FILE > $FILE.bak
	mv $FILE.bak $FILE
}

update_jni() {
	FILE=$CURRENT_PROJECT/android/jni/Android.mk

	sed 's/\/..\/..\/..\//\/..\/..\/libs\//' $FILE > $FILE.bak
	mv $FILE.bak $FILE
}

setup_eclipse_project() {
	cp dat/android/.classpath $CURRENT_PROJECT/android/.classpath
	sed "s/project_name/$PROJECT_NAME\_android/" dat/android/.project > $CURRENT_PROJECT/android/.project
	cp dat/android/Makefile $CURRENT_PROJECT/android
}

modify_android_mk() {
	FILE=$CURRENT_PROJECT/android/jni/Android.mk

	#modify LOCAL_SRC_FILES
	sed "s#.*cpp.*##" $FILE > $FILE.bak
	mv $FILE.bak $FILE
	sed 's#LOCAL_MODULE_FILENAME := libgame#&\'$'\n''LOCAL_SRC_FILES := helloworld/main.cpp\'$'\n''MY_FILES := $(wildcard $(shell find $(LOCAL_PATH)/../../Classes -type f -name '*.cpp'))\'$'\n''MY_FILES := $(MY_FILES:$(LOCAL_PATH)/%=%)\'$'\n''LOCAL_SRC_FILES += $(MY_FILES)\'$'\n''#' $FILE > $FILE.bak
	mv $FILE.bak $FILE

	#modify LOCAL_C_INCLUDES
	sed "s#LOCAL_C_INCLUDES := \$(LOCAL_PATH)/../../Classes#LOCAL_C_INCLUDES := \$(shell find \$(LOCAL_PATH)/../../Classes -type d)#" $FILE > $FILE.bak
	mv $FILE.bak $FILE
}

run_main() {
	save_current_dir
	check_env
	if [ ${PARAMS[0]} = "-standalone" ]; then
		echo "run as standalone"
		input_project_name
	else
		create_android_project
		input_project_name
		copy_project_to_current_dir
	fi	
	update_lib_reference
	update_build_native
	### remove the following command since CC2DX 0.13
	#update_jni
	setup_eclipse_project
	modify_android_mk
	
	echo "=== Complete ==="
}

PARAMS=$@

run_main
