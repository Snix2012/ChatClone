//
//  SlidyViewController.swift
//  ChatClone
//
//  Created by claire.roughan on 15/05/2019.
//  Copyright © 2019 Claire Roughan. All rights reserved.
//
//// networkErrorTitleLabel.topAnchor.constraint(lessThanOrEqualTo: networkIconImageView.bottomAnchor, constant: 50.0).isActive = true

import UIKit

class SlidyViewController: UIViewController {

    @IBOutlet weak var labelToSlideIn: UILabel!
    
    var borderWidth : CGFloat = 4 // Should be less or equal to the `radius` property
    var radius : CGFloat = 10
    var triangleHeight : CGFloat = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
//        drawSquare()
 //        drawCircle()
//        drawSpeachBubble()
//
        
      //  drawAdminSpeachBubble()
      //  drawUserSpeachBubble()
        
        
        //Example usage:
        let bubbleLayer = CAShapeLayer()
        bubbleLayer.path = bubblePathForContentSize(contentSize:CGSize(width: 100, height: 50)).cgPath
        bubbleLayer.fillColor = (UIColor(red: 54/255, green: 172/255, blue: 224/255, alpha: 0.8)).cgColor
        bubbleLayer.strokeColor = UIColor.darkGray.cgColor
        bubbleLayer.lineWidth = 1.0
        bubbleLayer.position = CGPoint.zero
        self.view.layer.addSublayer(bubbleLayer)
        
    }
    
    @objc func handleSwipes(sender:UISwipeGestureRecognizer) {
        
        if(sender.direction == .left) {
            print("swipe left")
           let labelLeftSwipePosition = CGPoint(x: labelToSlideIn.frame.origin.x - 200, y: labelToSlideIn.frame.origin.y)
            
            labelToSlideIn.frame = CGRect(x: labelLeftSwipePosition.x, y: labelLeftSwipePosition.y, width: labelToSlideIn.frame.size.width, height: labelToSlideIn.frame.size.height)
        }
        
        if(sender.direction == .right) {
            print("swipe right")
             let labelRightSwipePosition = CGPoint(x: labelToSlideIn.frame.origin.x + 200, y: labelToSlideIn.frame.origin.y)
            
             labelToSlideIn.frame = CGRect(x: labelRightSwipePosition.x, y: labelRightSwipePosition.y, width: labelToSlideIn.frame.size.width, height: labelToSlideIn.frame.size.height)
        }
    }
    
    fileprivate func drawUserSpeachBubble() {
        // Round the corners of the rectangle
        let rectanglePath = UIBezierPath.init(roundedRect: CGRect(x: 240, y: 120, width: 70, height: 40), byRoundingCorners: [.topLeft, .topRight, .bottomLeft ], cornerRadii: CGSize(width: 12.0, height: 12.0))
        
        let rectangle = CAShapeLayer()
        
        // Apply the squarePath to our layer
        rectangle.path = rectanglePath.cgPath
        rectangle.fillColor = (UIColor(red: 253/255, green: 229/255, blue: 72/255, alpha: 0.8)).cgColor
        self.view.layer.addSublayer(rectangle)
    }
    
    fileprivate func drawAdminSpeachBubble() {
        // Round the corners of the rectangle
        let rectanglePath = UIBezierPath.init(roundedRect: CGRect(x: 30, y: 170, width: 70, height: 40), byRoundingCorners: [.topLeft, .topRight, .bottomRight ], cornerRadii: CGSize(width: 12.0, height: 12.0))
        
        let rectangle = CAShapeLayer()
        
        // Apply the squarePath to our layer
        rectangle.path = rectanglePath.cgPath
        rectangle.fillColor = (UIColor(red: 152/255, green: 208/255, blue: 77/255, alpha: 0.8)).cgColor
        self.view.layer.addSublayer(rectangle)
    }
    
    fileprivate func drawSpeachBubble() {
        
        let ovalPath = UIBezierPath.init(ovalIn: CGRect(x:250, y:100, width:150, height:150))
        UIGraphicsBeginImageContext(CGSize(width: 300, height: 300));
        
        //this gets the graphic context
        let context = UIGraphicsGetCurrentContext()
        
        //you can stroke and/or fill
        context!.setStrokeColor(UIColor.black.cgColor)
        context!.setFillColor(UIColor.lightGray.cgColor)
        ovalPath.fill()
        ovalPath.stroke()
        
        //now get the image from the context
        let bezierImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        let ovalImageView = UIImageView.init(image:  bezierImage)
        self.view.addSubview(ovalImageView)

//        let aRect = CGRect(x: 2.0, y: 2.0, width: (self.view.bounds.size.width * 0.95), height: (self.view.bounds.size.width * 0.60))
//        UIGraphicsBeginImageContext(aRect)
//        ctx!.setStrokeColor(UIColor.black.cgColor)
//        ctx!.setLineWidth(CGFloat(2.0))
//        ctx!.fillEllipse(in:aRect)
//        ctx!.strokeEllipse(in: aRect)
//
//        ctx?.beginPath()
//        ctx?.move(to: CGPoint(x:self.view.bounds.size.width * 0.10, y:self.view.bounds.size.width * 0.48))
//        ctx!.addLine(to: CGPoint(x:3.0, y:self.view.bounds.size.height * 0.80))
//        ctx!.addLine(to: CGPoint(x:20.0, y:self.view.bounds.size.height * 0.70))
//        ctx!.closePath()
//        ctx!.fillPath()
//
//        ctx!.beginPath()
//        ctx!.move(to: CGPoint(x:self.view.bounds.size.width * 0.10, y:self.view.bounds.size.width * 0.48))
//        ctx!.addLine(to: CGPoint(x: 3.0, y:self.view.bounds.size.height * 0.80))
//        ctx!.strokePath()
//
//        ctx!.beginPath()
//        ctx!.move(to: CGPoint(x:3.0, y:self.view.bounds.size.height * 0.80))
//        ctx!.addLine(to: CGPoint(x:20.0, y:self.view.bounds.size.height * 0.70))
//        ctx!.strokePath()
    }
    
    
    fileprivate func drawSquare() {
        //draw the shape path in coordinates
        let squarePath = UIBezierPath()
        
        // Move to start coordinates
        squarePath.move(to: CGPoint(x: 100, y: 400))
        
        // Do drawing lines
        squarePath.addLine(to: CGPoint(x: 100, y: 400))
        squarePath.addLine(to: CGPoint(x: 200, y: 200))
        squarePath.addLine(to: CGPoint(x: 100, y: 200))
        squarePath.addLine(to: CGPoint(x: 100, y: 100))
        
        // close drawing
        squarePath.close()
        
        // CAShapeLayer, this is whats drawn to the screen
        let square = CAShapeLayer()
        
        // Apply the squarePath to our layer
        square.path = squarePath.cgPath
        square.fillColor = UIColor.red.cgColor // Fill it with colour
        self.view.layer.addSublayer(square)
    }
   
    
    fileprivate func bubblePathForContentSize(contentSize: CGSize) -> UIBezierPath {
        let rect = CGRect(origin:CGPoint(x: 20, y: 250), size: CGSize(width: contentSize.width, height: contentSize.height)).offsetBy(dx: radius, dy: radius + triangleHeight)
        let path = UIBezierPath();
        let radius2 = radius - borderWidth / 2 // Radius adjasted for the border width
        
        path.move(to: CGPoint(x: rect.maxX - triangleHeight * 2, y: rect.minY - radius2))
        path.addLine(to: CGPoint(x: rect.maxX - triangleHeight, y: rect.minY - radius2 - triangleHeight))
        path.addArc(withCenter: CGPoint(x: rect.maxX, y: rect.minY),
                    radius: radius2,
                    startAngle: CGFloat(-(Double.pi/2)), endAngle: 0, clockwise: true)
        path.addArc(withCenter: CGPoint(x: rect.maxX, y: rect.maxY),
                    radius: radius2,
                    startAngle: 0, endAngle: CGFloat(Double.pi/2), clockwise: true)
        path.addArc(withCenter: CGPoint(x: rect.minX, y: rect.maxY),
                    radius: radius2,
                    startAngle: CGFloat(Double.pi/2),endAngle: CGFloat(Double.pi), clockwise: true)
        path.addArc(withCenter: CGPoint(x: rect.minX, y: rect.minY),
                    radius: radius2,
                    startAngle: CGFloat(Double.pi), endAngle: CGFloat(-(Double.pi/2)), clockwise: true)
        path.close()
        return path
    }

    
    fileprivate func arrow(from start: CGPoint, to end: CGPoint, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat) -> CGPath {
        let length = hypot(end.x - start.x, end.y - start.y)
        let tailLength = length - headLength
        
        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint { return CGPoint(x: x, y: y) }
        var points: [CGPoint] = [
            p(0, tailWidth / 2),
            p(tailLength, tailWidth / 2),
            p(tailLength, headWidth / 2),
            p(length, 0),
            p(tailLength, -headWidth / 2),
            p(tailLength, -tailWidth / 2),
            p(0, -tailWidth / 2)
        ]
        
        let cosine = (end.x - start.x) / length
        let sine = (end.y - start.y) / length
        var transform = CGAffineTransform(a: cosine, b: sine, c: -sine, d: cosine, tx: start.x, ty: start.y)
        
        let path = CGMutablePath()
        path.addLines(between: points, transform: transform)
        path.closeSubpath()
        
        return (path) as CGPath
    }

    
    fileprivate func drawCircle() {
        let theArrow = CAShapeLayer()
        theArrow.path = arrow(from: CGPoint(x: 110, y: 140), to: CGPoint(x: 110, y: 140),
                              tailWidth: 1, headWidth: 10, headLength: 8)
        
        self.view.layer.addSublayer(theArrow)
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 200, height: 200))
        let img = renderer.image { ctx in
//            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
//
//            let circle = CGRect(x: 100, y: 100 , width: 100, height: 100)
//            ctx.cgContext.addEllipse(in: circle)
//            ctx.cgContext.drawPath(using: .fillStroke)
           
            

        }
        self.view.addSubview(UIImageView.init(image: img))
        
        
    }
}



//let circle = CAShapeLayer()
//circle.path = circlePathWithCenter(center: CGPoint(x: 200,y: 400), radius: 50).cgPath
//circle.fillColor = UIColor.blue.cgColor
//self.view.layer.addSublayer(circle)
