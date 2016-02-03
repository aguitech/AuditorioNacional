//
//  ViewInicio.swift
//  Comparte tu Experiencia
//
//  Created by Gerardo Canseco Montiel on 26/01/16.
//  Copyright © 2016 Aguitech. All rights reserved.
//

import UIKit

class ViewInicio : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nombreDefault = NSUserDefaults.standardUserDefaults()
        
        if(nombreDefault.valueForKey("usuario") == nil){
            let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
            let pantallaPuntitos = nuestroStoryBoard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(pantallaPuntitos, animated:true, completion: nil)
            })
        }else if (nombreDefault.valueForKey("usuario") != nil){
            let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
            let pantallaMenu = nuestroStoryBoard.instantiateViewControllerWithIdentifier("NavigationSeleccion") as! MenuMyNavigationController
            
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(pantallaMenu, animated:true, completion: nil)
            })
        }
        
        
    }
}