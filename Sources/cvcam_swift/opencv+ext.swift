//
//  File.swift
//  
//
//  Created by apocolipse on 10/13/23.
//

import opencv

// Geometry helper extensions

extension cv.Point {
  func scaled(by factor: Double) -> cv.Point {
    .init(Int32(Double(x) * factor), Int32(Double(y) * factor))
  }
}

extension cv.Rect {
  var center: cv.Point {
    .init(cvRound(Double(x) + Double(width) * 0.5),
          cvRound(Double(y) + Double(height) * 0.5))
  }
  var origin: cv.Point {
    return .init(x, y)
  }
  
  var antiOrigin: cv.Point {
    return .init(x + width - 1, y + height - 1)
  }
  
  func contains(_ point: cv.Point) -> Bool {
    return point.x >= x && point.x <= width && point.y >= y && point.y <= height
  }
  
  func contains(_ rect: cv.Rect) -> Bool {
    return contains(rect.origin) && contains(rect.antiOrigin)
  }
}

extension cv.Mat {
  var frame: cv.Rect {
    cv.Rect(.init(), cv.Size(rows, cols))
  }
}
