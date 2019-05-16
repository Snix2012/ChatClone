//
//  SlidyViewController.swift
//  ChatClone
//
//  Created by claire.roughan on 15/05/2019.
//  Copyright © 2019 Claire Roughan. All rights reserved.
//

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
   

}
