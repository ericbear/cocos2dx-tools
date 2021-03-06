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

copy_project_to_current_dir() {
	echo "Input the project name:"
	read PROJECT_NAME
	CURRENT_PROJECT=$CURRENT_DIR
	
	rm -rf $CURRENT_PROJECT/linux
	cp -rf dat/linux $CURRENT_PROJECT

	rm -rf $CURRENT_PROJECT/unittests
	cp -rf dat/unittests $CURRENT_PROJECT
	unzip $CURRENT_PROJECT/unittests/cpputest.zip -d $CURRENT_PROJECT/unittests
	rm -rf $CURRENT_PROJECT/unittests/cpputest.zip
	rm -rf $CURRENT_PROJECT/unittests/__MACOSX
}

update_setting() {
	#update Makefile
	echo "update Makefile"
	_FILE_=$CURRENT_PROJECT/linux/Makefile
	sed  "s/PROJECT_NAME/$PROJECT_NAME/" $_FILE_ > $_FILE_.bak
	mv $_FILE_.bak $_FILE_
	sed  "s#.*COCOS2DX_ROOT_DIR.*##" $_FILE_ > $_FILE_.bak
	mv $_FILE_.bak $_FILE_

	#update .project
	echo "update .project"
	_FILE_=$CURRENT_PROJECT/linux/.project
	sed  "s/PROJECT_NAME/$PROJECT_NAME/" $_FILE_ > $_FILE_.bak
	mv $_FILE_.bak $_FILE_
	sed  "s#COCOS2DX_ROOT_DIR#$COCOS2DX_ROOT#" $_FILE_ > $_FILE_.bak
	mv $_FILE_.bak $_FILE_

	#update .cproject
	echo "update .cproject"
	_FILE_=$CURRENT_PROJECT/linux/.cproject
	sed  "s/PROJECT_NAME/$PROJECT_NAME/" $_FILE_ > $_FILE_.bak
	mv $_FILE_.bak $_FILE_
	sed "s#COCOS2DX_LOC_PATH#$COCOS2DX_ROOT#" $_FILE_ > $_FILE_.bak
	mv $_FILE_.bak $_FILE_
}

fix_build_linux() {
	FMOD_DIR=$COCOS2DX_ROOT/CocosDenshion/third_party/linux/fmod/api/lib/
	rm -rf $FMOD_DIR/libfmodex.so
	rm -rf $FMOD_DIR/libfmodexL.so
	ln -s $FMOD_DIR/libfmodex-* $FMOD_DIR/libfmodex.so
	ln -s $FMOD_DIR/libfmodexL-* $FMOD_DIR/libfmodexL.so
	FMOD_DIR=$COCOS2DX_ROOT/CocosDenshion/third_party/linux/fmod/lib64/api/lib
	rm -rf $FMOD_DIR/libfmodex64.so
        rm -rf $FMOD_DIR/libfmodexL64.so
        ln -s $FMOD_DIR/libfmodex64-* $FMOD_DIR/libfmodex64.so
        ln -s $FMOD_DIR/libfmodexL64-* $FMOD_DIR/libfmodexL64.so
}

build_linux() {
	cd $COCOS2DX_ROOT
	sh ./build-linux.sh
	FMOD_DIR=$COCOS2DX_ROOT/CocosDenshion/third_party/linux/fmod/api/lib/
	cp -R $FMOD_DIR/libfmodex.so lib/linux/Debug
	cp -R $FMOD_DIR/libfmodex.so lib/linux/Release
	cp -R $FMOD_DIR/libfmodexL.so lib/linux/Debug
	cp -R $FMOD_DIR/libfmodexL.so lib/linux/Release
	FMOD_DIR=$COCOS2DX_ROOT/CocosDenshion/third_party/linux/fmod/lib64/api/lib
	cp -R $FMOD_DIR/libfmodex64.so lib/linux/Debug
	cp -R $FMOD_DIR/libfmodex64.so lib/linux/Release
	cp -R $FMOD_DIR/libfmodexL64.so lib/linux/Debug
	cp -R $FMOD_DIR/libfmodexL64.so lib/linux/Release
	cd $CURRENT_DIR
}

run_main() {
	save_current_dir
	check_env
	copy_project_to_current_dir
	update_setting

	fix_build_linux
	build_linux

	echo "you can import the project ($CURRENT_DIR/linux) into eclipse"
}

run_main
