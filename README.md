cocos2dx-tools
==============
useful tools for cocos2d-x


add android into existing ios project (XCode 4.X)
- copy 3 files (add_android_into_ios_project.sh, classpath.dat & project.dat) into your ios project 
- run the script "add_android_into_ios_project.sh"
	- make sure that "COCOS2DX_ROOT", "NDK_ROOT" & "ANDROID_SDK_ROOT" are defined on your environment
- the procedure should be as same as COCOS2DX "create_android_project.sh" except one more prompt "Input the project name:"
- for android native code compile, pls run the script "build_native.sh" under android folter.

2012-06-05:
- update the script to support CC2DX 0.13
- generate the ecipse project

2012-06-04:
- init the project
- add the android/add_android_into_ios_project.sh
    - a cross-platform integration tool for generate the android project and merge it into existing iOS project (XCode 4.X)
