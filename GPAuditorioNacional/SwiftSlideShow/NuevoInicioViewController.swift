//
//  NuevoInicioViewController.swift
//  Comparte tu Experiencia
//
//  Created by Gerardo Canseco Montiel on 05/02/16.
//  Copyright © 2016 Aguitech. All rights reserved.
//

import UIKit

class NuevoInicioViewController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func iniciarRegistro2(sender: UIButton) {
        let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let registroPantalla = nuestroStoryBoard.instantiateViewControllerWithIdentifier("pantallaRegistro") as! RegistroController
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(registroPantalla, animated:true, completion: nil)
        })
        /*dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(registroPantalla, animated:true, completion: nil)
        })*/
    }
}
