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
    @IBOutlet weak var emailValue: UITextField!
    
    
    
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
        let emailField = emailValue.text
        
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://emocionganar.com/admin/panel/registro_ios.php")!)
            request.HTTPMethod = "POST"
            let postString = "email=\(emailField!)&nombre=\(nombreField!)"
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
                print("responseString = \(responseString)")
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
