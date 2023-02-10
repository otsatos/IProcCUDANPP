# CUDA at Scale Independent Project 
An attempt to perform some basic Image Processing operations utilizing the CUDA NPP Library.
## Project Description
The main goal of this project is to create an application that can perform image processing on a large amount of data (100s of small images). 
In this project we use both CUDA API and NVIDIA NPP Library that gives us direct access to the GPU's parallel computational elements.
OpenCV Library is used here to perform IO operations and to apply identical Image processing algorithms as a way to validate CUDA NPP output.

The application prints out information about processing time in both libraries with no intentions to make comparisons but as a starting point to explore further and to optimize our code in the future.

Below the main steps are described for RGB image to gray conversion by CUDA.
The application initially scans the ```./images/src/``` folder for images in a jpg or png format.
For every image in the dataset, OpenCV  ```cv::imread``` function is called that loads the image into a ```cv::Mat``` host memory object using the file path specified by the first argument. The second argument ```cv::IMREAD_COLOR``` specifies the BGR 8-bit format we want the image in the host memory(this is the order of RGB color schema images are decoded by OpenCV). 
```OpenCV cv::Mat``` object offers two important properties that are usefull in our application.
```cv::Mat::total()``` Returns the total number of pixels.
```cv::Mat::elemSize()``` Returns the size in bytes of each matrix element that is the pixel in or case.

cudaMalloc is used to allocate device memory for the the 3-channeled original image and the output one-channeled grey image, both of NPP::Bpp8u type.
cudaMemcpy function copies array elements from host source image object to the Cuda device source image object.

```nppiColorToGray_8u_C3C1R``` Cuda function is called for conversion from RGB to single gray color chanel.
A special 3-elements array of type ```Npp32f``` is used to pass conversion coefficients to the function is being used.

At the final step ```cudaMemcpy``` copies the device output image to the host allocated cv::Mat output image.



## Code Organization
```bin/```  
This folder contains the binary code that manually is copied from the build tree folder.

```bin/images/``` :Images root folder      
..................```src/``` : Source Images Folder   
..................```output/```  : Output Images base folder  
................................```cudanp/```  : CUDA output images  
................................```opencv/```  : OPEN CV output images  
This folder contains all the sample data are use by the application


```src/```
The source code should be placed here in a hierarchical fashion, as appropriate.
```build```
Build tree
```docs```
Documentation material and artifacts
```README.md```
This file should hold the description of the project so that anyone cloning or deciding if they want to clone this repository can understand its purpose to help with their decision.

```INSTALL```
This file should hold the human-readable set of instructions for installing the code so that it can be executed. If possible it should be organized around different operating systems, so that it can be done by as many people as possible with different constraints.

```CMakeLists.txt```
CMakeLists.txt file contains the directives and instructions for compiling and building the code by setting the compiler and c++ standard that is required, specific libraries, including directories etc. 

## Prerequisites

