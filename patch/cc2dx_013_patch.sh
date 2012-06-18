#!/bin/bash

check_env() {
	if [ $COCOS2DX_ROOT"xxx" = "xxx" ]; then
		echo "pls set COCOS2DX_ROOT on your env"
		exit
	fi
}

fix_ccfiletuils_cpp() {
	FILE="$COCOS2DX_ROOT/cocos2dx/platform/CCFileUtils.cpp"
	PATTERN=`grep -n "const char\* CCFileUtils::fullPathFromRelativePath" "$FILE"`
	if [ $PATTERN"xx" = "xx" ]; then
		echo "'const char\* CCFileUtils::fullPathFromRelativePath' is not existing on $FILE"
	else
		LINE=`echo "$PATTERN" | sed "s#:.*##"`
		sed "`expr $LINE + 1`s#return \"\";#return pszRelativePath;#" $FILE > $FILE.bak
		sed "`expr $LINE + 2`s#return \"\";#return pszRelativePath;#" $FILE > $FILE.bak
		mv $FILE.bak $FILE
	fi
}

run_main() {
	check_env
	fix_ccfiletuils_cpp
}

run_main
