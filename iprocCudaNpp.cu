#include "helper.h"

const std::string outfolderopencv="./images/output/opencv/";
const std::string outfoldercudanpp="./images/output/cudanpp/";

std::vector<std::string> srcImagesFilenames()
{
    char* jpgext=".JPG";
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


void opencvGrayscale(std::string flocation)
{    
    cv::Mat srcimg = cv::imread(flocation);
    cv::Mat grayimg;
    cv::cvtColor(srcimg, grayimg, cv::COLOR_BGR2GRAY);
    
    #ifdef _WIN32 
       std::string fname = flocation.substr(flocation.find_last_of("/\\") + 1);   
    #else
       std::string fname = flocation.substr(flocation.find_last_of("/") + 1);  
    #endif        
    cv::imwrite(outfolderopencv+fname,grayimg);
    std::cout << "Image size in bytes "<<fname <<" Source:"<< srcimg.step[0] * srcimg.rows<<" Gray:" << grayimg.step[0] * grayimg.rows <<"\n";
}

int main(int, char **)
{
  auto fnames = srcImagesFilenames(); 
  for(int i=0;i<fnames.size();i++)
  {         
     std::string fn(fnames[i]); 
     opencvGrayscale(fn);
  }

  return 0;
}
