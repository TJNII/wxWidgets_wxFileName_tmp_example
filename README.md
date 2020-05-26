wxWidgets wxFileName /tmp Bug Example
=====================================

This repo is an example of the bug underlying https://github.com/cjcliffe/CubicSDR/issues/823

Issue
-----

`wxFileName.IsDirWritable()` returns `false` for `/tmp`.
It returns `true` for `/tmp/` and subdirectories in `/tmp`.

```
Target path /tmp:
        Exists: True
        IsDirWritable: False

Target path /tmp/:
        Exists: True
        IsDirWritable: True

Target path /tmp/subdir:
        Exists: True
        IsDirWritable: True
```

Running
-------

```bash
$ docker build -t test/wxwidgetstest . && docker run --rm -ti test/wxwidgetstest
Sending build context to Docker daemon  4.096kB
Step 1/14 : FROM ubuntu:18.04
 ---> c3c304cb4f22
Step 2/14 : RUN apt-get update
 ---> Using cache
 ---> 828a92855a19
Step 3/14 : RUN apt-get install -y git build-essential automake cmake libgtk-3-dev freeglut3 freeglut3-dev
 ---> Using cache
 ---> c315639c222d
Step 4/14 : RUN apt-get install -y ca-certificates wget
 ---> Using cache
 ---> c1a96102b6e4
Step 5/14 : RUN mkdir /src
 ---> Using cache
 ---> bca8187e29f2
Step 6/14 : WORKDIR /src
 ---> Using cache
 ---> 0dcb8c624eed
Step 7/14 : RUN wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.3/wxWidgets-3.1.3.tar.bz2
 ---> Using cache
 ---> 16963b4a1982
Step 8/14 : RUN tar -xvjf wxWidgets-3.1.3.tar.bz2  &&     cd wxWidgets-3.1.3/  &&     mkdir -p ~/Develop/wxWidgets-staticlib &&     ./autogen.sh &&     ./configure --with-opengl --disable-shared --enable-monolithic --with-libjpeg --with-libtiff --
with-libpng --with-zlib --disable-sdltest --enable-unicode --enable-display --enable-propgrid --disable-webkit --disable-webview --disable-webviewwebkit --prefix=`echo ~/Develop/wxWidgets-staticlib` CXXFLAGS="-std=c++0x" &&     make -j4 &&     mak
e install
 ---> Using cache
 ---> f8fc794ee07e
Step 9/14 : COPY ./ /src/test
 ---> fcce3f2864f7
Step 10/14 : RUN cd /src/test &&     g++ -o test test.cpp `/src/wxWidgets-3.1.3/wx-config --cxxflags --libs`
 ---> Running in 784ee754fbe2
test.cpp: In function 'int main()':
test.cpp:8:56: warning: ISO C++ forbids converting a string constant to 'char*' [-Wwrite-strings]
   char *test_paths[3] = {"/tmp", "/tmp/", "/tmp/subdir"};
                                                        ^
test.cpp:8:56: warning: ISO C++ forbids converting a string constant to 'char*' [-Wwrite-strings]
test.cpp:8:56: warning: ISO C++ forbids converting a string constant to 'char*' [-Wwrite-strings]
Removing intermediate container 784ee754fbe2
 ---> 0f59ed7a8ced
Step 11/14 : RUN useradd notroot
 ---> Running in e99ec73db3e3
Removing intermediate container e99ec73db3e3
 ---> ae2753f1ab44
Step 12/14 : USER notroot
 ---> Running in 124785ba8d73
Removing intermediate container 124785ba8d73
 ---> d26f553ba7b1
Step 13/14 : RUN mkdir /tmp/subdir
 ---> Running in 2cea038a9a45
Removing intermediate container 2cea038a9a45
 ---> 492336256f76
Step 14/14 : CMD /src/test/test
 ---> Running in 13cb6a2897e9
Removing intermediate container 13cb6a2897e9
 ---> 85363d1b4f31
Successfully built 85363d1b4f31
Successfully tagged test/wxwidgetstest:latest
Target path /tmp:
        Exists: True
        IsDirWritable: False

Target path /tmp/:
        Exists: True
        IsDirWritable: True

Target path /tmp/subdir:
        Exists: True
        IsDirWritable: True

```
