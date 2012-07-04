#!/bin/bash

check_env() {
	if [ $COCOS2DX_ROOT"xxx" = "xxx" ]; then
		echo "pls set COCOS2DX_ROOT on your env"
		exit
	fi
}

fix_ccfileutils_cpp() {
	FILE="$COCOS2DX_ROOT/cocos2dx/platform/CCFileUtils.cpp"
	LINE=`grep -n "const char\* CCFileUtils::fullPathFromRelativePath" "$FILE" | sed "s#:.*##"`
	if [ $LINE"xx" = "xx" ]; then
		echo "'const char\* CCFileUtils::fullPathFromRelativePath' is not existing on $FILE"
	else
		sed "`expr $LINE + 2`s#return.*#return pszRelativePath;#" $FILE > $FILE.bak
		mv $FILE.bak $FILE
	fi
}

fix_ccfileutils_ios_mm() {
	FILE="$COCOS2DX_ROOT/cocos2dx/platform/ios/CCFileUtils_ios.mm"
	LINE=`grep -n "std::string CCFileUtils::getWriteablePath()" "$FILE" | sed "s#:.*##"`
	if [ $LINE"xx" = "xx" ]; then
		echo "'std::string CCFileUtils::getWriteablePath()' is not existing on $FILE"
	else
		REPLACE=$'\t\t''NSAutoreleasePool\* pool = [NSAutoreleasePool new];\'$'\n''&'
		sed "`expr $LINE + 3`s#.*NSSearchPathForDirectoriesInDomains.*#$REPLACE#" $FILE > $FILE.bak
		mv $FILE.bak $FILE
		REPLACE='[pool release];\'$'\n\t\t''&'
		sed "`expr $LINE + 8`s#return strRet;#$REPLACE#" $FILE > $FILE.bak
		mv $FILE.bak $FILE
	fi
}

run_main() {
	check_env
	fix_ccfileutils_cpp
	fix_ccfileutils_ios_mm
}

run_main
