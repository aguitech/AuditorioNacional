//
//  IniciarSesionController.swift
//  SwiftSlideShow
//
//  Created by Hector Aguilar on 06/01/16.
//  Copyright © 2016 Aguitech. All rights reserved.
//

import UIKit

class IniciarSesionController: UIViewController {

    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func iniciarSesion(sender: UIButton) {

        let emailField = emailValue.text
        let passwordField = passwordValue.text
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://emocionganar.com/admin/panel/login_ios.php")!)
        request.HTTPMethod = "POST"
        let postString = "email=\(emailField!)&password=\(passwordField!)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            print("responseString Esto imprime = \(responseString!)")
            
            
            if(responseString! == "success"){
                print("Debe de continuar la app")
                
                
                
                /*
                NSOperationQueue.mainQueue().addOperationWithBlock {
                self.performSegueWithIdentifier("registroExitoso", sender: self)
                }
                */
                print("--------------------------")
                
                
                //Código que guarda el nombre de usuario
                let nombreDefault = NSUserDefaults.standardUserDefaults()
                nombreDefault.setValue(self.emailValue.text!, forKey: "usuario")
                nombreDefault.synchronize()
                
                
                //Código que liga a otro View
                let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                let registroExitosoPantalla = nuestroStoryBoard.instantiateViewControllerWithIdentifier("NavigationSeleccion") as! MyNavigationControllerSeleccion
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.presentViewController(registroExitosoPantalla, animated:true, completion: nil)
                })
                
            }
            if(responseString! == "Registro duplicado"){
                print("El registro ya esta registrado")
                dispatch_async(dispatch_get_main_queue(), {
                    //self.avisoLabel.text = "El usuario ya ha sido registrado"
                })
                
            }
            if(responseString! == "false"){
                
                print("Debe de continuar la app")
                
                dispatch_async(dispatch_get_main_queue(), {
                    //self.avisoLabel.text = "Es necesario llenar todos los campos."
                })
                
                
            }
            
        }
        task.resume()
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
