//
//  NuevoInicioViewController.swift
//  Comparte tu Experiencia
//
//  Created by Gerardo Canseco Montiel on 05/02/16.
//  Copyright © 2016 Aguitech. All rights reserved.
//

import UIKit

class NuevoInicioViewController : UIViewController{
    
    var color = UIColor(red: 0.234375, green: 0.74609375, blue: 0.6640625, alpha: 1.0)
    var color_fondo_navbar = UIColor(red: (10/255), green: (20/255), blue: (38/255), alpha: 1.0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cambio de color
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.barTintColor = color_fondo_navbar
        
        
        //agrega imagen como título
        let logo = UIImage(named: "titulo_be_part_of")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
        
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
