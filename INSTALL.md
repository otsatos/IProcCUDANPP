# Installation instructions

## Overview
This document provides information about installing this software and its dependencies.

## Software installation
Once the code for the project is built, place the binary file into the ```bin``` folder. Note that bin folder can be created in the filesystem at your preference.
In the same ```bin``` folder, directory ```images``` must be created following this structure.
- ```bin/images/``` is images root folder.  
  - ```src/```  folder should have the original dataset before running the application.  
    - ```output/```  is the images output  base folder.  
      - ```cudanp/```  is CUDA output images folder.  
      - ```opencv/```  is OPEN CV output images folder. 

## Prerequisites

- Install OpenCV Library
  - [Linux Installation](https://docs.opencv.org/4.x/d7/d9f/tutorial_linux_install.html)
  - [Windows Installation](https://docs.opencv.org/4.x/d3/d52/tutorial_windows_install.html)

- Install NVIDIA CUDA
  - [NVIDIA CUDA Installation Guide for Linux](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/)
  - [NVIDIA CUDA Installation Guide for Microsoft Windows](https://docs.nvidia.com/cuda/cuda-installation-guide-microsoft-windows/)

- [Download CUDA NPP Library files to include in your codebase](https://docs.nvidia.com/cuda/npp/index.html)