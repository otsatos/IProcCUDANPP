#include <iostream>
#include <stdio.h>
#include <string.h>
#include <fstream>
#include <vector>
//#include <filesystem>
#include <sys/types.h>
#include <dirent.h>
#include <opencv2/opencv.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc.hpp>

#include <cuda_runtime.h>
#include <helper_cuda.h>
#include <helper_string.h>
#include <nppi.h>
#include <npp.h>
#include <nppi_geometry_transforms.h>

#ifdef _WIN32
    #include"wtime.h"
#else
    #include <sys/time.h>
#endif
