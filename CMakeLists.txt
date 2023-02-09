cmake_minimum_required(VERSION 3.8)
project(IProcCUDANPP VERSION 0.1.0 LANGUAGES CXX CUDA)

set(OpenCV_DIR "/home/coder/project/opencv/opencv2")

find_package(OpenCV REQUIRED )
find_package(CUDA REQUIRED)
enable_language(CUDA)

set(CMAKE_CUDA_COMPILER /usr/local/cuda-11.3/bin/nvcc)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CUDA_STANDARD_REQUIRED TRUE)

include_directories( "/home/coder/project/opencv/opencv2/include"  
                     "/home/coder/project/opencv/opencv2/include/opencv4" 
                     "/usr/local/cuda/lib64" 
                     "/usr/local/cuda/include" 
                     "/home/coder/project/Common"                      
                     "/home/coder/project/Common/UtilNPP" 
                      )

cuda_add_executable(iproccudanpp iprocCudaNpp.cu)
target_link_libraries( iproccudanpp  "/home/coder/project/opencv/opencv2/lib/libopencv_core.so" 
                                  "/home/coder/project/opencv/opencv2/lib/libopencv_imgcodecs.so" 
                                  "/home/coder/project/opencv/opencv2/lib/libopencv_highgui.so"
                                  "/home/coder/project/opencv/opencv2/lib/libopencv_imgproc.so"
                                  "/home/coder/project/opencv/opencv2/lib/libopencv_imgproc.so.4.7.0"   
                                  "/home/coder/project/opencv/opencv2/lib/libopencv_imgproc.so.407"
                                  "/usr/local/cuda-11.3/lib64/libnppc.so"    
                                  "/usr/local/cuda-11.3/lib64/libnppial.so" 
                                  "/usr/local/cuda-11.3/lib64/libnppicc.so"
                                  "/usr/local/cuda-11.3/lib64/libnppif.so"  
                                  "/usr/local/cuda-11.3/lib64/libnppig.so" 
                                  "/usr/local/cuda-11.3/lib64/libnppicc.so" 
                                  "/usr/local/cuda-11.3/lib64/libnppim.so"
                                  "/usr/local/cuda-11.3/lib64/libnpps.so"
                                  )

target_compile_options(iproccudanpp PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:
                       -lcudart
                       -lcuda
                       -lnppc
                       -lnppi
                       -lnppial
                       -std=c++17 
                       >)

list(APPEND CUDA_NVCC_FLAGS "--std=c++17")
set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})

