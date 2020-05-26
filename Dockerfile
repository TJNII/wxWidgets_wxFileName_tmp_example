FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y git build-essential automake cmake libgtk-3-dev freeglut3 freeglut3-dev
RUN apt-get install -y ca-certificates wget

RUN mkdir /src
WORKDIR /src

RUN wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.3/wxWidgets-3.1.3.tar.bz2
RUN tar -xvjf wxWidgets-3.1.3.tar.bz2  && \
    cd wxWidgets-3.1.3/  && \
    mkdir -p ~/Develop/wxWidgets-staticlib && \
    ./autogen.sh && \
    ./configure --with-opengl --disable-shared --enable-monolithic --with-libjpeg --with-libtiff --with-libpng --with-zlib --disable-sdltest --enable-unicode --enable-display --enable-propgrid --disable-webkit --disable-webview --disable-webviewwebkit --prefix=`echo ~/Develop/wxWidgets-staticlib` CXXFLAGS="-std=c++0x" && \
    make -j4 && \
    make install

COPY ./ /src/test

RUN cd /src/test && \
    g++ -o test test.cpp `/src/wxWidgets-3.1.3/wx-config --cxxflags --libs`

RUN useradd notroot
USER notroot
RUN mkdir /tmp/subdir

CMD /src/test/test
