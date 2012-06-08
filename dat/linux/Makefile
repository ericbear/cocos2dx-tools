CC      = gcc
CXX     = g++
TARGET	= PROJECT_NAME
CCFLAGS = -Wall -g -O2 
CXXFLAGS = -Wall -g -O2 
VISIBILITY = 

COCOS2DX_ROOT=COCOS2DX_ROOT_DIR

INCLUDES = -I$(COCOS2DX_ROOT)/cocos2dx/platform/third_party/linux \
            -I$(COCOS2DX_ROOT)/cocos2dx/include \
            -I$(COCOS2DX_ROOT)/cocos2dx \
            -I$(COCOS2DX_ROOT)/cocos2dx/platform \
            -I$(COCOS2DX_ROOT)/CocosDenshion/include \
            -I../Classes/

DEFINES = -DLINUX

OBJECTS = ./main.o \
        ../Classes/AppDelegate.o \
        ../Classes/HelloWorldScene.o 

STATICLIBS =  
SHAREDLIBS = -L$(COCOS2DX_ROOT)/lib/linux/Debug -lcocos2d -lrt -lz -lcocosdenshion -Wl,-rpath,$(COCOS2DX_ROOT)/lib/linux/Debug/

#$(shell $(COCOS2DX_ROOT)/build-linux.sh $<)
####### Build rules
$(TARGET): $(OBJECTS) 
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(DEFINES) $(OBJECTS) -o $(TARGET) $(SHAREDLIBS) $(STATICLIBS)
	
####### Compile
%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(DEFINES) $(VISIBILITY) -c $< -o $@

%.o: %.c
	$(CC) $(CCFLAGS) $(INCLUDES) $(DEFINES) $(VISIBILITY) -c $< -o $@
		
clean: 
	rm -f $(OBJECTS) $(TARGET) core

all:
	make
