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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        drawSquare()
        
        drawCircle()
        
        
        // Only round the top left and right corners of the rectangle.// Only round the top left and right corners of the rectangle.
        let rectanglePath = UIBezierPath.init(roundedRect: CGRect(x: 170, y: 70, width: 60, height: 40), byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 4.0, height: 4.0))
        
        let rectangle = CAShapeLayer()
        
        // Apply the squarePath to our layer
        rectangle.path = rectanglePath.cgPath
        rectangle.fillColor = UIColor.green.cgColor
        self.view.layer.addSublayer(rectangle)

        
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
    
    fileprivate func drawCircle() {
        
//       let circlePath = UIBezierPath()
//        circlePath.addCurve(to: <#T##CGPoint#>, controlPoint1: <#T##CGPoint#>, controlPoint2: <#T##CGPoint#>)
       
        
    }
    
    fileprivate func drawSquare() {
        //draw the shape path in coordinates
        let squarePath = UIBezierPath()
        
        // Move to start coordinates
        squarePath.move(to: CGPoint(x: 300, y: 300))
        
        // Do drawing lines
        squarePath.addLine(to: CGPoint(x: 200, y: 100))
        squarePath.addLine(to: CGPoint(x: 200, y: 200))
        squarePath.addLine(to: CGPoint(x: 100, y: 200))
        
        // close drawing
        squarePath.close()
        
        // CAShapeLayer, this is whats drawn to the screen
        let square = CAShapeLayer()
        
        // Apply the squarePath to our layer
        square.path = squarePath.cgPath
        square.fillColor = UIColor.red.cgColor // Fill it with colour
        self.view.layer.addSublayer(square)
    }
   

}

//
//func circlePathWithCenter(center: CGPoint, radius: CGFloat) -> UIBezierPath {
//    let circlePath = UIBezierPath()
//    circlePath.addArc(withCenter: center, radius: radius, startAngle: -CGFloat(M_PI), endAngle: -CGFloat(M_PI/2), clockwise: true)
//    circlePath.addArc(withCenter: center, radius: radius, startAngle: -CGFloat(M_PI/2), endAngle: 0, clockwise: true)
//    circlePath.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI/2), clockwise: true)
//    circlePath.addArc(withCenter: center, radius: radius, startAngle: CGFloat(M_PI/2), endAngle: CGFloat(M_PI), clockwise: true)
//    circlePath.close()
//    return circlePath
//}
//
//
//let circle = CAShapeLayer()
//circle.path = circlePathWithCenter(center: CGPoint(x: 200,y: 400), radius: 50).cgPath
//circle.fillColor = UIColor.blue.cgColor
//self.view.layer.addSublayer(circle)
