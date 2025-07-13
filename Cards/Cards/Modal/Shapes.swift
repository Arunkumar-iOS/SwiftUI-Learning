//
//  Shapes.swift
//  Cards
//
//  Created by Arunkumar on 30/06/25.
//

import Foundation
import SwiftUI



struct Shapes {
//AnyShape is a Type erasure, because we can not directly save a shape into array because shape ancestor has an associatedType. We can not save an associatedType values into array. In that case we can convert the shape into Type Erasure type so we can use like this.
    static let shapes: [AnyShape] = [
      AnyShape(Circle()), AnyShape(Rectangle()),
      AnyShape(Cone()), AnyShape(Lens())
    ]
// above code holds a type-erased list of all your defined shapes.
}


struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
      let width = rect.width
      let height = rect.height
      var path = Path()
      path.addLines([
        /*
         You want to convert fixed (hardcoded) points into relative points so that your shape can resize smoothly to fit any space.
         
         Calculation
         You can calculate these coordinates by dividing the hard coded coordinate(like 20) by the original frame size. For example, 20.0 / 150.0 comes out at about 0.13.
         150 is a rect width size which is come from parent.
         
         calculation
         draw a shape using 150*150 frame with hardcoded value then convert hardcoded values into relative value.
         Step 1: Convert to relative values
         
         Point        x / 150    y / 150
         (20, 130)       0.13       0.87
         (130, 130)      0.87       0.87
         (75, 20)        0.5        0.13
         
         */
        CGPoint(x: width * 0.13, y: height * 0.2),
        CGPoint(x: width * 0.87, y: height * 0.47),
        CGPoint(x: width * 0.4, y: height * 0.93)
      ])
      path.closeSubpath()
      return path
    }
    //Now your shape shrink and grow based on the screen size.

}

struct Cone: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        //To add an arc, we need a radius. Radius is a distance from the centre point to finishing line.
        //This below line gives a radius which is smallet value from the rect width or height.
        //ex - midX = 100 midY = 200 then min value is 100
        let radius = min(rect.midX, rect.midY)
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 180),
            clockwise: true)
        
        path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        path.addLine(to: CGPoint(x: rect.midX + radius, y: rect.midY))
        path.closeSubpath()

        return path
    }
}


/*
 
 When drawing a curved line (called a quadratic curve), you need 3 points:

 Start point – where the curve begins
 End point – where the curve ends
 Control point – pulls the curve toward itself and shapes the curve
 
 summary
 Start → End = straight line
 Add control point = makes it a curve
 Control point decides how the curve bends
 */
struct Lens: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
      //Start Point
      path.move(to: CGPoint(x: 0, y: rect.midY))
      path.addQuadCurve(
        to: CGPoint(x: rect.width, y: rect.midY),
        control: CGPoint(x: rect.midX, y: 0))
      //again start a curve from last point which is right centre of rectangle.
      path.addQuadCurve(
        to: CGPoint(x: 0, y: rect.midY),
        control: CGPoint(x: rect.midX, y: rect.height))
      path.closeSubpath()

    return path
  }
}



//Example of how you can create a shape.
/*
//New shape that conforms the Shape protocol, so we can create a new one.
struct Triangle: Shape {
    //This is a required function that is from the Shape protocol and it gives a rectangle. using that rectangle area we can create a shapes.
    func path(in rect: CGRect) -> Path {
        var path = Path()
        //You can draw here whatever you want.
        /*
         If you want your triangle to keep its shape and automatically resize to fit the space,
         you should use relative values (like percentages),
         not fixed numbers like x: 20 or y: 130.
         */
 
 //Here you can use array of points to create a subpath.
        path.move(to: CGPoint(x: 20, y: 30))  // 📍 Move pen to start point
        
        path.addLine(to: CGPoint(x: 130, y: 70))// ✏️ Draw line from (20,30) → (130, 70)
        path.addLine(to: CGPoint(x: 60, y: 140)) // ✏️ Line to (60,140)
        
        
        //above three lines are subpath. Can we can close this when drawing is finished.
        //like back to point A
        path.closeSubpath()
        
        return path
    }
}
 */


#Preview(traits: .sizeThatFitsLayout) {
    
    Lens()
        .stroke(style: .init(lineWidth: 2, lineCap: .round, lineJoin: .round))
    //You can only use stroke(_:) on objects conforming to Shape, so you must place the modifier directly after Lens().
    //You can customize the store lines if we want to use - - and we can animate it like marching ants.
    //if we use dashPhase effectively we can animate dashed borders (like “marching ants”)
       // .stroke(style: .init(lineWidth: 5, lineCap: .round, lineJoin: .round, dash: [5, 10, 1, 5], dashPhase: 10))
        .background(.yellow)
        .padding()
    
    /*
    Triangle()
        .background(.yellow)
        .aspectRatio(1, contentMode: .fit)
        .padding()
     */
}
