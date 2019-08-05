FROM node:alpine
MAINTAINER Frank Fan <fanyije@gmail.com>
RUN mkdir /tmp/opencv
WORKDIR /tmp/opencv
RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/4.1.1.zip
RUN unzip opencv.zip
RUN wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.1.1.zip
RUN unzip opencv_contrib.zip
RUN mkdir /tmp/opencv/opencv-4.1.1/build
WORKDIR /tmp/opencv/opencv-4.1.1/build
RUN apk update
RUN apk add --no-cache ca-certificates
RUN apk add --no-cache git build-base musl-dev alpine-sdk cmake clang clang-dev make gcc g++ libc-dev linux-headers
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv/opencv_contrib-4.1.1/modules -D BUILD_DOCS=OFF BUILD_EXAMPLES=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_opencv_java=OFF -D BUILD_opencv_python=OFF -D BUILD_opencv_python2=OFF -D BUILD_opencv_python3=OFF ..
RUN make -j4
RUN make install
RUN rm -rf /tmp/opencv
