//
//  SlidyViewController.swift
//  ChatClone
//
//  Created by claire.roughan on 15/05/2019.
//  Copyright © 2019 Claire Roughan. All rights reserved.
//

import UIKit

class SlidyViewController: UIViewController {

    @IBOutlet weak var lableToSlideIn: UILabel!
    
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
           let lableLeftSwipePosition = CGPoint(x: lableToSlideIn.frame.origin.x - 200, y: lableToSlideIn.frame.origin.y)
            
            lableToSlideIn.frame = CGRect(x: lableLeftSwipePosition.x, y: lableLeftSwipePosition.y, width: lableToSlideIn.frame.size.width, height: lableToSlideIn.frame.size.height)
        }
        
        if(sender.direction == .right) {
            print("swipe right")
             let lableRightSwipePosition = CGPoint(x: lableToSlideIn.frame.origin.x + 200, y: lableToSlideIn.frame.origin.y)
            
             lableToSlideIn.frame = CGRect(x: lableRightSwipePosition.x, y: lableRightSwipePosition.y, width: lableToSlideIn.frame.size.width, height: lableToSlideIn.frame.size.height)
        }
    }
   

}
