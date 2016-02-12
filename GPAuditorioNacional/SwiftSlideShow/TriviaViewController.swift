//
//  TriviaViewController.swift
//  Comparte tu Experiencia
//
//  Created by Gerardo Canseco Montiel on 10/02/16.
//  Copyright © 2016 Aguitech. All rights reserved.
//

import UIKit

class TriviaViewController : UIViewController{
    
     var arreglo_trivia : [Trivia] = [Trivia]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
    }
}