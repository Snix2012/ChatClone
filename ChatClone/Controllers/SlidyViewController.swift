//
//  SlidyViewController.swift
//  ChatClone
//
//  Created by claire.roughan on 15/05/2019.
//  Copyright © 2019 Claire Roughan. All rights reserved.
//

import UIKit

class SlidyViewController: UIViewController {

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
        }
        
        if(sender.direction == .right) {
            print("swipe right")
        }
    }
   

}
