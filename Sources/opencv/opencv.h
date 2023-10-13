#include <opencv2/opencv.hpp>
#include <opencv2/core/types_c.h>

typedef std::vector<cv::Rect> RectVector;


//std::vector<cv::Rect> cvDetectMultiScale(cv::CascadeClassifier classifier, cv::Mat image,
//                                   double scaleFactor = 1.1,
//                                   int minNeighbors = 3, 
//                                   int flags = 0,
//                                   cv::Size minSize = cv::Size(),
//                                   cv::Size maxSize = cv::Size() ){
//  std::vector<cv::Rect> output;
//  classifier.detectMultiScale(image, output, scaleFactor, minNeighbors,
//                              flags, minSize, maxSize);
//  return output;
//}
//
