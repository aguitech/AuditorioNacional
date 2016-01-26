//
//  ViewController.swift
//  SlideoutMenu
//
//  Created by Jared Davidson on 4/8/15.
//  Copyright (c) 2015 Archetapp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var Label: UILabel!
    @IBOutlet var Open: UIBarButtonItem!
    
    var varView = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        if (varView == 0){
            Label.text = "Strings"
            
        }
        else {
            
            Label.text = "Others"
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

