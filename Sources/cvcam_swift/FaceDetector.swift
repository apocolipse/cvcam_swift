//
//  File.swift
//  
//
//  Created by apocolipse on 10/13/23.
//

import opencv

actor FaceDetector {
  private(set) var cascade: cv.CascadeClassifier
  private(set) var faces: RectVector = RectVector()
  
  var scale: Double = 1.0
  
  private var updateTask: Task<Void, Never>?
  
  init(cascade: cv.CascadeClassifier, scale: Double = 1.0) {
    print("cascade: \(cascade)")
    self.cascade = cascade
    self.scale = scale
  }
  
  private func reset() {
    updateTask = nil
  }
  
  private func updateFaces(_ _faces: RectVector) {
    faces = _faces
  }
  
  private func _detect(img: cv.Mat) {
    // convert to gray
    var gray = cv.Mat(img.rows, img.cols, 0) // CV_8UC1 = 0, alloc in swift else leak
    cv.cvtColor(.init(img), .init(gray), 6, 1)

    // resize the grayscale image
    let fx = 1.0 / scale
    var small = cv.Mat(cvRound(Double(img.rows) * scale), 
                       cvRound(Double(img.cols) * scale), 0)
    cv.resize(.init(gray), .init(small), .init(), fx, fx, 1)
    cv.equalizeHist(.init(small), .init(small))
    
    // detect faces of different sizes using cascade classifier
    // CASCADE_SCALE_IMAGE = 2
    cascade.detectMultiScale(.init(small), &faces, 1.1, 2, 0|2, cv.Size(50, 50), cv.Size())
    
    // reset the task now that we're finished
    updateTask = nil
  }
  
  
  /// run detection in dedicated task, no overlap or blocking
  func detect(img: cv.Mat) {
    guard updateTask == nil else { return } // just return if we're already processing
    updateTask = Task { [weak self] in
      guard let self else { return }
      await self._detect(img: img)
    }
  }
  
  func drawFaces(img: inout cv.Mat) {
    // draw rects around the faces
    for faceRect in faces {
      let color = cv.Scalar(255,0,0,0)
      cv.rectangle(.init(img),
                   faceRect.origin.scaled(by: scale),
                   faceRect.antiOrigin.scaled(by: scale),
                   color, 3, 8, 0)
      
    }
  }
}
