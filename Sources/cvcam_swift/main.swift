// The Swift Programming Language
// https://docs.swift.org/swift-book

import CxxStdlib
import opencv

@MainActor
func cam_in() async throws {
  // CAP_AVFOUNDATION = 1200, index 1 on new macs as 0 is cont. cam
  var cap = cv.VideoCapture.init(1, 1200)

  let detector = FaceDetector(cascade: .init("haarcascade_frontalface_default.xml"),
                              scale: 0.25)
  
  // buffer
  var frame = cv.Mat.init()

  repeat {
    _ = cap >> frame
    
    await detector.detect(img: frame) // detached, non blocking
    await detector.drawFaces(img: &frame) // access to faces array is atomic but not blocking

    // display
    cv.imshow("frame", .init(frame))
    
    // repeat while frame is good and no escape key
  } while !frame.empty() && cv.waitKey(10) != 27
  
  // cleanup
  cv.destroyAllWindows()
}

func main() async throws {
  try await cam_in()
}

try await main()
