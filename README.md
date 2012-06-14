cocos2dx-tools
==============
useful tools for cocos2d-x

modify the iOS project structure
- copy all files to your project folder which is as same as xcode project file
- run the script "setup_ios_project.sh"
	- make sure that "COCOS2DX_ROOT" is defined on your environment

modify the android project structure from existing one
- execute the creation script under cocos2dx folder
- after that copy your project from cocos2dx folder to your workspace
- copy all files to your project folder which directory constain "android" folder
- run the script "setup_android_project.sh"
	- make sure that "COCOS2DX_ROOT", "NDK_ROOT" & "ANDROID_SDK_ROOT" are defined on your environment
- import the project into eclipse under "android" sub-folder

add android project into existing ios project (XCode 4.X)
- copy all files to your project folder which is same as xcode project file
- run the script "add_android_into_ios_project.sh"
	- make sure that "COCOS2DX_ROOT", "NDK_ROOT" & "ANDROID_SDK_ROOT" are defined on your environment
- the procedure should be as same as COCOS2DX "create_android_project.sh" except one more prompt "Input the project name:"
- for android native code compile, pls run the script "build_native.sh" under android folter.
- import the project into eclipse under "android" sub-folder

add linux project into existing project
- copy all files into the directory which is as same as your project level
- run the script "add_linux_into_project.sh"
	- make sure that "COCOS2DX_ROOT", "NDK_ROOT" & "ANDROID_SDK_ROOT" are defined on your environment
- the procedure will compile the cocos2dx library
- import the project into eclipse under "linux" sub-folder

standard project folder structure:
- ![folder structure](https://dl.dropbox.com/u/41312550/cocos2dx_project_folder.png)

2012-06-14:
- modify the Makefile to include all *.o
- modify the android/jni/Android.mk to include all *.cpp

2012-06-13:
- fix a bug for removing android folder during execute the script for linux
- fix a bug for wrong fmod linkage
- fix a bug for "add_android_into_ios_project.sh"

2012-06-11:
- add the creation script to restructure the folder for iOS which is generated by XCode
- add the creation script to restructure the folder for android which is generated by Cocos2dx's script
- modify the android and linux script for the above changes
- the scripts should be executed under the project folder

2012-06-08:
- update the file structure
- add the creation script for linux platform
	- using eclipse as IDE on linux

2012-06-05:
- update the script to support CC2DX 0.13
- generate the ecipse project

2012-06-04:
- init the project
- add the android/add_android_into_ios_project.sh
    - a cross-platform integration tool for generate the android project and merge it into existing iOS project (XCode 4.X)
