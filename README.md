# CUDA at Scale 
An attempt to perform basic Image Processing operations utilizing the **CUDA NPP** Library.
## Project Description
The main goal of this project is to create an application that can perform image processing on a large amount of data (100s of small images).
In this project, we use the **CUDA API** and the **NVIDIA NPP** Library, which both give us direct access to the GPU's parallel computational elements.
The **OpenCV** Library is used here to perform IO operations and to apply identical image processing algorithms as a way to validate CUDA NPP output.

The application prints out information about processing time in both libraries with no intention to make comparisons, as this project serves as a starting point to explore further and optimize our code in the future.

The core function of this program is to convert RGB images to grayscale with the **CUDA NPP** library. Here is an overview of the workflow's main steps and the key elements of the library being used.

- The application initially scans the ```./images/src/``` folder for images in **JPG** or **PNG** format. For every image in the dataset, OpenCV 's ```cv::imread``` function is called, which loads the image into a ```cv::Mat``` host memory object using the file path specified by the first argument. The second argument, ```cv::IMREAD_COLOR```, specifies the BGR 8-bit format we want the image in the host memory (this is the order RGB color schema images are decoded by **OpenCV**). 
- ```OpenCV cv::Mat``` object offers two important properties that are useful in our application:
  - ```cv::Mat::total()``` : returns the total number of pixels.
  - ```cv::Mat::elemSize()``` : returns the size in bytes of each matrix element, that is the pixel in our case.

- ```cudaMalloc``` is used to allocate device memory for the the 3-channeled original image and the output one-channeled grey image, both of ```NPP::Bpp8u``` type.
- ```cudaMemcpy``` function copies array elements from the host source image object to the Cuda device source image object.

- ```nppiColorToGray_8u_C3C1R``` Cuda function is called for conversion from RGB to a single gray color channel. A special 3-element array of type ```Npp32f``` is used to pass conversion coefficients.

- At the final step, ```cudaMemcpy``` copies the device output image to the host allocated ```cv::Mat``` output image.

## Code Execution  
In a Linux command prompt, type the name of the binary file. We assume that  ```$application/bin``` is our current folder. 
> ./iproccudanpp

This is a part of the output of the application 

> GPU Device 0: Volta with compute capability 7.0  
>   NPP Library Version 11.3.3  
>   CUDA Driver  Version: 11.6  
>   CUDA Runtime Version: 11.3  
>   Device 0: Volta, Compute SM 7.0 detected  
>  
>  
> Image size in bytes IMG_1776.JPG Source:36,578,304 ... Elapsed Time:17,882  
> Image size in bytes IMG_2030.JPG Source:36,578,304 ... Elapsed Time:11,625  
> Image size in bytes IMG_6663.JPG Source:36,578,304 ... Elapsed Time:26,459  
> Image size in bytes IMG_6267.JPG Source:36,578,304 ... Elapsed Time:11,635  
> ...  
> Image size in bytes IMG_6662.JPG Source:36,578,304 ... Elapsed Time:11,754  
>  
> Total Elapsed Time using CUDA NPP library: 1,319,489  
>  
  
This is a sample image converted from RGB to grayscale.   

![Original image](/docs/IMG_4205_original_small.JPG "Original Image")  
  
![Grayscale image](/docs/IMG_4205_gray_small.JPG "Grayscale Image")  


## Code Organization
- ```bin/``` folder contains the binary code file ```iproccudanpp``` and ```images``` folder.  
  - ```bin/images/``` is images root folder.   
  - ```src/``` folder should have the original dataset before running the application.  
    - ```output/```  is the images output  base folder.  
      - ```cudanp/```  is CUDA output images folder.  
      - ```opencv/```  is OPEN CV output images folder.  

- ```src/``` folder contains the source code where *.cu/*.h files are placed.
- ```build``` is the build tree folder used by CMake tools. The code provided was successfully compiled on a Linux system.  
- ```docs``` folder is provided for documentation material and artifacts.

- ```INSTALL.md``` file provides a human-readable set of instructions for installing the application along with certain information about prerequisites and possible dependencies.  

- ```CMakeLists.txt``` file contains the directives and instructions for compiling and building the code by setting the compiler and c++ standard that is required, specific libraries and including directories among others. This file was created to compile and build the program on a Linux system. In order for this code to be compiled on a Windows system, references to the OPENCV and CUDA NPP libraries and include directories must be changed accordingly.
