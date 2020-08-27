message("-- Found tkDNN")
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
set(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} --std=c++11 -fPIC")

#set(OpenCV_ROOT "/shared/opencv-4.1.2/install")
#set(OpenCV_LIBS "/shared/opencv-4.1.2/install/lib")
#set(OPENCV_INCLUDE_DIRS "/shared/opencv-4.1.2/install/include/opencv4")

find_package(CUDA REQUIRED)
set(OpenCV_STATIC ON)
find_package(OpenCV REQUIRED PATHS /shared/opencv-4.1.2/install_static NO_DEFAULT_PATH)
find_package(CUDNN REQUIRED)

set(tkDNN_INCLUDE_DIRS 
	${CUDA_INCLUDE_DIRS} 
	${OPENCV_INCLUDE_DIRS} 
    ${CUDNN_INCLUDE_DIRS}
)

set(tkDNN_LIBRARIES 
    tkDNN 
    kernels 
    ${CUDA_LIBRARIES} 
    ${CUDA_CUBLAS_LIBRARIES}
	${CUDNN_LIBRARIES}
	${OpenCV_LIBS}
)

set(tkDNN_FOUND true)
