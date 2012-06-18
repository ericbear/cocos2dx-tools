#!/bin/bash

init() {
	echo "Input the project name:"
	read PROJECT_NAME
}

check_env() {
	if [ $COCOS2DX_ROOT"xxx" == "xxx" ]; then
		echo "pls set COCOS2DX_ROOT on your env"
		exit
	fi
}

restructure() {
	cp -rif $PROJECT_NAME/ .
	rm -rf $PROJECT_NAME
	mv Prefix.pch ios/Prefix.pch
	rm -rf libs/
	mkdir libs
	ln -s $COCOS2DX_ROOT/cocos2dx libs/cocos2dx
	ln -s $COCOS2DX_ROOT/CocosDenshion libs/CocosDenshion
	ln -s $COCOS2DX_ROOT/Box2D libs/Box2D
}

modify_project() {
	echo "modify $PROJECT_NAME.xcodeproj"

	FILE=$PROJECT_NAME.xcodeproj/project.pbxproj
	sed "s#path = $PROJECT_NAME#name = $PROJECT_NAME#" $FILE > $FILE.bak
	mv $FILE.bak $FILE
	sed "s#INFOPLIST_FILE = $PROJECT_NAME/Resources/Info.plist#INFOPLIST_FILE = Resources/Info.plist#" $FILE > $FILE.bak
	mv $FILE.bak $FILE
	sed "s#GCC_PREFIX_HEADER = $PROJECT_NAME/Prefix.pch#GCC_PREFIX_HEADER = ios/Prefix.pch#" $FILE > $FILE.bak
	mv $FILE.bak $FILE
	sed "s#path = Prefix.pch#path = ios/Prefix.pch#" $FILE > $FILE.bak
	mv $FILE.bak $FILE
	sed "s#\$(PROJECT_NAME)/libs/cocos2dx#libs/cocos2dx#" $FILE > $FILE.bak
	mv $FILE.bak $FILE
	sed "s#\$(PROJECT_NAME)/libs/CocosDenshion/include#libs/CocosDenshion/include#" $FILE > $FILE.bak
	mv $FILE.bak $FILE
}

run_main() {
	check_env
	init
	restructure
	modify_project
}

run_main
