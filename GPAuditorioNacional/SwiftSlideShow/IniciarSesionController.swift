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

        enum JSONError: String, ErrorType {
            case NoData = "ERROR: no data"
            case ConversionFailed = "ERROR: conversion from JSON failed"
        }
        
        let emailField = emailValue.text
        let passwordField = passwordValue.text
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://emocionganar.com/admin/panel/login_ios_new.php")!)
        request.HTTPMethod = "POST"
        let postString = "email=\(emailField!)&password=\(passwordField!)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            do {
                guard let dat = data else { throw JSONError.NoData }
                guard let json = try NSJSONSerialization.JSONObjectWithData(dat, options: []) as? NSDictionary else { throw JSONError.ConversionFailed }
                //print(json)
                print(json["success"]!)
                //print(json["result"])
                //print(json["result"]!)
                //print(json["result"]![0])
                //print(json["result"]![1]!["id"]!)
                //print(json["result"]![2]["nombre"]!)
                //print(json["result"]![2]["nombre"])
                
                
                if(json["success"]! as! NSObject == 1){
                    print(json["id"]!)
                    print(json["nombre"]!)
                    
                    //Código que guarda el nombre de usuario
                    let nombreDefault = NSUserDefaults.standardUserDefaults()
                    nombreDefault.setValue(self.emailValue.text!, forKey: "usuario")
                    nombreDefault.setValue(json["id"]!, forKey: "id")
                    nombreDefault.setValue(json["nombre"]!, forKey: "nombre")
                    nombreDefault.synchronize()
                    
                    
                    //Código que liga a otro View
                    let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                    let registroExitosoPantalla = nuestroStoryBoard.instantiateViewControllerWithIdentifier("NavigationSeleccion") as!   MenuMyNavigationController
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.presentViewController(registroExitosoPantalla, animated:true, completion: nil)
                    })
                    
                }else{
                    
                }
                
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch {
                print(error)
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
