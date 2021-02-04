#!/bin/bash

#based on https://devtalk.nvidia.com/default/topic/1042035/installing-opencv4-on-xavier/ & https://github.com/markste-in/OpenCV4XAVIER/blob/master/buildOpenCV4.sh

# Compute Capabilities can be found here https://developer.nvidia.com/cuda-gpus#compute
ARCH_BIN=7.2 # AGX Xavier
#ARCH_BIN=6.2 # Tx2
#ARCH_BIN=6.1 # GT 1030

echo "Please make sure the ARCH_BIN is set correctly accoring to your architecture"

if [ ! -d "/shared" ] 
then
	echo "Directory /shared DOES NOT exists. Has to be there or at least a symbolic link to it." 
	exit 1
fi

sudo apt-get install -y build-essential \
	unzip \
	pkg-config \
	libjpeg-dev \
	libpng-dev \
	libtiff-dev \
	libavcodec-dev \
	libavformat-dev \
	libswscale-dev \
	libv4l-dev \
	libxvidcore-dev \
	libx264-dev \
	libgtk-3-dev \
	libatlas-base-dev \
	gfortran \
	libgstreamer1.0-dev \
	libgstreamer-plugins-base1.0-dev \
	libdc1394-22-dev \
	libavresample-dev

cd /shared
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git

cd opencv && mkdir -p build && cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=../install_static \
	-D BUILD_SHARED_LIBS=OFF \
	-D INSTALL_PYTHON_EXAMPLES=OFF \
	-D INSTALL_C_EXAMPLES=OFF \
	-D OPENCV_EXTRA_MODULES_PATH='/shared/opencv_contrib/modules' \
	-D BUILD_EXAMPLES=OFF \
	-D WITH_CUDA=ON \
	-D CUDA_ARCH_BIN=${ARCH_BIN} \
	-D CUDA_ARCH_PTX="" \
	-D ENABLE_FAST_MATH=ON \
	-D CUDA_FAST_MATH=ON \
	-D WITH_CUBLAS=ON \
	-D WITH_LIBV4L=ON \
	-D WITH_GSTREAMER=ON \
	-D WITH_GSTREAMER_0_10=OFF \
	-D WITH_TBB=ON \
	../

make -j6
make install

echo "Done. Now you can remove the build directory to save space."
