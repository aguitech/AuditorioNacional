//
//  RegistroController.swift
//  SwiftSlideShow
//
//  Created by Hector Aguilar on 04/01/16.
//  Copyright © 2016 Aguitech. All rights reserved.
//

import UIKit

class RegistroController: UIViewController {

    @IBOutlet weak var nombreValue: UITextField!
    @IBOutlet weak var celularValue: UITextField!
    @IBOutlet weak var telefonoValue: UITextField!
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var codigoPostalValue: UITextField!
    @IBOutlet weak var confirmarEmailValue: UITextField!
    @IBOutlet weak var edadValue: UITextField!
    @IBOutlet weak var avisoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func crearRegistro(sender: AnyObject) {
        
        let nombreField = nombreValue.text
        let celularField = celularValue.text
        let telefonoField = telefonoValue.text
        let emailField = emailValue.text
        let codigoPostalField = codigoPostalValue.text
        let edadField = edadValue.text
        
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://emocionganar.com/admin/panel/registro_ios.php")!)
            request.HTTPMethod = "POST"
            let postString = "email=\(emailField!)&nombre=\(nombreField!)&celular=\(celularField!)&telefono=\(telefonoField!)&codigo_postal=\(codigoPostalField!)&edad=\(edadField!)"
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
                    
                    let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                    let registroExitosoPantalla = nuestroStoryBoard.instantiateViewControllerWithIdentifier("registroExitoso") as! RegistroExitosoController
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.navigationController!.pushViewController(registroExitosoPantalla, animated:true)
                    })

                }
                if(responseString! == "Registro duplicado"){
                    print("El registro ya esta registrado")
                    dispatch_async(dispatch_get_main_queue(), {
                        self.avisoLabel.text = "El usuario ya ha sido registrado"
                    })
                    
                }
                if(responseString! == "false"){

                    print("Debe de continuar la app")

                    dispatch_async(dispatch_get_main_queue(), {
                        self.avisoLabel.text = "Es necesario llenar todos los campos."
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
