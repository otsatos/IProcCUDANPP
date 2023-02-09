#include "helper.h"

const std::string outfolderopencv="./images/output/opencv/";
const std::string outfoldercudanpp="./images/output/cudanpp/";

timeval tiStart;
void twachstart()
{
    gettimeofday(&tiStart, 0);
}

int twatchend() {
    timeval tiEnd;
    gettimeofday(&tiEnd, 0);
    int t = (tiEnd.tv_sec - tiStart.tv_sec) * 1000000 + tiEnd.tv_usec - tiStart.tv_usec;
    tiStart = tiEnd;
    return t;
}

std::vector<std::string> srcImagesFilenames()
{   
    const char* imgFolder ="./images/src/";        
    std::vector<std::string> filenames;
    DIR *dr;
    struct dirent *en;
    dr = opendir(imgFolder); 
    if (dr) 
    {
        while ((en = readdir(dr)) != NULL) 
        {            
            std::string fullname(imgFolder);
            if (strstr(en->d_name,".JPG") || strstr(en->d_name,".jpg") || strstr(en->d_name,".PNG") || strstr(en->d_name,".png")) 
            {
                fullname+=en->d_name;
                std::string fname(fullname); //assign a value from *char on a constructor                   
                filenames.push_back(fname);
            }
        }
        closedir(dr);
    }    
    else if (dr == NULL) 
    {        
        perror("An error occurred while trying to access the specified folder.");       
        std::cout << "Specidied Folder may not exist:"<< imgFolder << "\n";       
    }
    return filenames;
}


int opencvGrayscale(std::string flocation)
{    
    cv::Mat srcimg = cv::imread(flocation);
    cv::Mat grayimg;

    twachstart();
    cv::cvtColor(srcimg, grayimg, cv::COLOR_BGR2GRAY);
    
    #ifdef _WIN32 
       std::string fname = flocation.substr(flocation.find_last_of("/\\") + 1);   
    #else
       std::string fname = flocation.substr(flocation.find_last_of("/") + 1);  
    #endif   
    int timeeaplsed=twatchend();     
    cv::imwrite(outfolderopencv+fname,grayimg);
    std::cout << "Image size in bytes "<<fname <<" Source:"<< srcimg.step[0] * srcimg.rows<<" OpenCV Gray:" << grayimg.step[0] * grayimg.rows << " Time elapsed:" << timeeaplsed;

    return timeeaplsed;
}

int convertToGrayCuda(std::string flocation)
{    
    cv::Mat srcimg = cv::imread(flocation, cv::IMREAD_COLOR);

    twachstart();

    Npp8u* srcimgdev;
    cudaMalloc((void**)&srcimgdev, srcimg.total() * srcimg.elemSize());
    Npp8u* outimgdev;
    cudaMalloc((void**)&outimgdev, srcimg.total());

    //Copy from the host memory input image to the CUDA device memory object
    cudaMemcpy(srcimgdev, srcimg.data, srcimg.total() * srcimg.elemSize(), cudaMemcpyHostToDevice);
    
    NppiSize sizeROI;
    sizeROI.width = srcimg.cols;
    sizeROI.height = srcimg.rows;
    //set conversion coefficients 
    const Npp32f convCoeff[3]={0.299,0.587,0.114};   
    //Perform the grayscale conversion
    nppiColorToGray_8u_C3C1R(srcimgdev, srcimg.step, outimgdev, srcimg.cols, sizeROI, convCoeff);

    // Allocate memory host memory output image
    cv::Mat outimghost(srcimg.rows, srcimg.cols, CV_8UC1);

    // Copy the result from the CUDA device memory to the host memory
    cudaMemcpy(outimghost.data, outimgdev, srcimg.total(), cudaMemcpyDeviceToHost);
            
    // Release the memory
    cudaFree(srcimgdev);
    cudaFree(outimgdev);

    int timeeaplsed=twatchend(); 
    
    // Save the grayscale image
    #ifdef _WIN32 
       std::string fname = flocation.substr(flocation.find_last_of("/\\") + 1);   
    #else
       std::string fname = flocation.substr(flocation.find_last_of("/") + 1);  
    #endif

    cv::imwrite(outfoldercudanpp+fname,outimghost);    
    std::cout <<" CUDA Gray:" << outimghost.step[0] * outimghost.rows << " Time elapsed:" << timeeaplsed;
    
    return timeeaplsed;
}

bool printNPPinfo(int argc, char *argv[])
{
  const NppLibraryVersion *libVer = nppGetLibVersion();

  printf("NPP Library Version %d.%d.%d\n", libVer->major, libVer->minor,libVer->build);

  int driverVersion, runtimeVersion;
  cudaDriverGetVersion(&driverVersion);
  cudaRuntimeGetVersion(&runtimeVersion);

  printf("  CUDA Driver  Version: %d.%d\n", driverVersion / 1000,(driverVersion % 100) / 10);
  printf("  CUDA Runtime Version: %d.%d\n", runtimeVersion / 1000, (runtimeVersion % 100) / 10);

  // Min spec is SM 1.0 devices
  bool bVal = checkCudaCapabilities(1, 0);
  return bVal;
}

int main(int argc, char *argv[])
{
  findCudaDevice(argc, (const char **)argv);
  
  if (printNPPinfo(argc, argv) == false)
  {
      exit(EXIT_SUCCESS);
  }

  long ttotalOpencv=0,ttotalCudanpp=0;  
  auto fnames = srcImagesFilenames(); 
  std::cout.imbue(std::locale(""));
  for(int i=0;i<fnames.size();i++)
  {         
     std::string fn(fnames[i]); 

     ttotalOpencv+=opencvGrayscale(fn);         
     ttotalCudanpp+=convertToGrayCuda(fn);     
     std::cout << "\n";     
  }
  std::cout <<"---------------------------------------------------------\n";
  std::cout<< "Total elapsed time with OPNCV library: " << ttotalOpencv<<"\n";
  std::cout<< "Total elapsed time with CUDA NPP library: " << ttotalCudanpp<<"\n";

  return 0;
}
