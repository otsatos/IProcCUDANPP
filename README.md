# CUDA at Scale Independent Project 
An attempt to perform some basic Image Processing operations utilizing the CUDA NPP Library.
## Project Description
The main goal of this project is to create an application that can perform image processing on a large amount of data (100s of small images). 
In this project we use both CUDA API and NVIDIA NPP Library that gives us direct access to the GPU's parallel computational elements.
OpenCV Library is used to perform IO operations and applying identical Image processing algorithms as a way to validate cCUDA NPP output.

The application may print information about processing time in both libraries with no intentions to make comparisons but as a starting point to explore further and to optimize the code in the future.

## Code Organization
```bin/```  
This folder contains the binary code that manually is copied from the build tree folder.

```images/``` :Images root folder      
.........```src/``` : Source Images Folder   
.........```output/```  : Output Images base folder  
..................```cudanp/```  : CUDA output images
..................```opencv/```  : OPEN CV output images
This folder contains all the sample data are use by the application

```lib/```
Any libraries that are not installed via the Operating System-specific package manager should be placed here, so that it is easier for inclusion/linking.

```src/```
The source code should be placed here in a hierarchical fashion, as appropriate.

```README.md```
This file should hold the description of the project so that anyone cloning or deciding if they want to clone this repository can understand its purpose to help with their decision.

```INSTALL```
This file should hold the human-readable set of instructions for installing the code so that it can be executed. If possible it should be organized around different operating systems, so that it can be done by as many people as possible with different constraints.

```Makefile or CMAkeLists.txt or build.sh```
There should be some rudimentary scripts for building your project's code in an automatic fashion.

```run.sh```
An optional script used to run your executable code, either with or without command-line arguments.

