//
//  ViewController2.swift
//  SwiftSideMenu
//
//  Created by Evgeny on 01.02.15.
//  Copyright (c) 2015 Evgeny Nazarov. All rights reserved.
//



import UIKit

class PostTriviaViewController: UIViewController, ENSideMenuDelegate {
    
    @IBOutlet weak var puntos_realizados_label: UILabel!
    @IBOutlet weak var tiempo_label: UILabel!
    @IBOutlet weak var fecha_label: UILabel!
    @IBOutlet weak var evento: UILabel!
    @IBOutlet weak var premio: UILabel!
    
    var respuestas_post : String = String()
    var tiempo_segundos : Int = 0
    var id_usuario : String = String()
    
    //Defincion de colores
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
        
        //Esconde Boton hacia atras
        self.navigationItem.hidesBackButton = true
        
        
        self.sideMenuController()?.sideMenu?.delegate = self
        
        let nombreDefault = NSUserDefaults.standardUserDefaults()

        if (nombreDefault.valueForKey("id") != nil){
            id_usuario = nombreDefault.valueForKey("id") as! String
            print("El id del usuario es: ")
            print(id_usuario)
            
        }

        //salida.text = "\(respuestas_post)"
        print("Funciona correcto")
        
        print("Funciona correctamente")
        
        print("\(respuestas_post)")
        
        
        
        enum JSONError: String, ErrorType {
            case NoData = "ERROR: no data"
            case ConversionFailed = "ERROR: conversion from JSON failed"
        }
        
        //let emailField = emailValue.text
        //let passwordField = passwordValue.text
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://emocionganar.com/admin/panel/webservice_resultado_trivia.php")!)
        request.HTTPMethod = "POST"
        //let postString = "email=\(emailField!)&password=\(passwordField!)"
        let postString = "valores=\(respuestas_post)&id=\(id_usuario)"
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
                    //print(json["id"]!)
                    //print(json["nombre"]!)
                    print("Aqui va el sucess")
                    print(json["resultado"]!)
                    //print(json["resultado"]![0])
                    print(json["resultado"]![0]["respuestas_correctas"] as! String)
                    
                    
                    //print(json["resultado"]![0]["id_resultado_trivia"]!)
                    //print(json["resultado"]![0]!["id_resultado_trivia"]!)
                    
                    //Código que guarda el nombre de usuario
                    //let nombreDefault = NSUserDefaults.standardUserDefaults()
                    //nombreDefault.setValue(self.emailValue.text!, forKey: "usuario")
                    //nombreDefault.setValue(json["id"]!, forKey: "id")
                    //nombreDefault.setValue(json["nombre"]!, forKey: "nombre")
                    //nombreDefault.synchronize()
                    
                    
                    //Código que liga a otro View
                    //let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                    //let registroExitosoPantalla = nuestroStoryBoard.instantiateViewControllerWithIdentifier("NavigationSeleccion") as!   MenuMyNavigationController
                    
                    let arregloJsonList = json["resultado"]
                    
                    //print("Arreglo JsonWeather\(arregloJsonList)")
                    
                    if let nsArrayJsonList = arregloJsonList as? NSArray{
                        
                        //Itinerar por todo nuestro arregloJsonList
                        
                        nsArrayJsonList.enumerateObjectsUsingBlock({ objeto, index, stop in
                            
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                for(var i = 0 ; i < nsArrayJsonList.count ; i++){
                                    if(index == i){
                                        /*
                                        let trivia_ayuda : Trivia = Trivia()
                                        trivia_ayuda.id_pregunta = objeto["id_pregunta"] as! String
                                        trivia_ayuda.pregunta = objeto["pregunta"] as! String
                                        trivia_ayuda.respuesta1 = objeto["respuesta1"] as! String
                                        trivia_ayuda.respuesta2 = objeto["respuesta2"] as! String
                                        trivia_ayuda.respuesta3 = objeto["respuesta3"] as! String
                                        trivia_ayuda.respuesta4 = objeto["respuesta4"] as! String
                                        trivia_ayuda.id_respuesta1 = objeto["id_respuesta1"] as! String
                                        trivia_ayuda.id_respuesta2 = objeto["id_respuesta2"] as! String
                                        trivia_ayuda.id_respuesta3 = objeto["id_respuesta3"] as! String
                                        trivia_ayuda.id_respuesta4 = objeto["id_respuesta4"] as! String
                                        */
                                        //self.arreglo_trivia.append(trivia_ayuda)
                                        print("fecha de creación")
                                        
                                        print("\(objeto["fecha_creacion"])")
                                        /*
                                        print("\(trivia_ayuda.pregunta)")
                                        print("\(trivia_ayuda.respuesta1)")
                                        print("\(trivia_ayuda.respuesta2)")
                                        print("\(trivia_ayuda.respuesta3)")
                                        print("\(trivia_ayuda.respuesta4)")
                                        */
                                    }
                                    if(nsArrayJsonList.count - 1 == index){
                                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                                            //self.btnIniciarOutlet.alpha = 1.0
                                        })
                                    }
                                }
                                //print(self.arreglo_trivia)
                                /*if (index == self.numero_descarga!){
                                let descripcion = objeto["descripcion"] as! String
                                self.informacion.text = descripcion
                                self.evento.text = objeto["blog"] as? String
                                //self.fecha.text = objeto["fecha"] as? String
                                self.nombre.text = objeto["titulo"] as? String
                                let imagen_url = objeto["imagen"] as! String
                                self.load_image("\(imagen_url)")
                                }*/
                                
                            })
                        })
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        //self.presentViewController(registroExitosoPantalla, animated:true, completion: nil)
                        self.puntos_realizados_label.text = (json["resultado"]![0]["respuestas_correctas"] as! String) + " PUNTOS"
                        self.tiempo_label.text = ("\(self.tiempo_segundos) SEGUNDOS")
                        self.fecha_label.text = (json["resultado"]![0]["fecha_creacion"] as! String) + " " + (json["resultado"]![0]["hora_creacion"] as! String) + "HRS"
                        self.evento.text = (json["resultado"]![0]["evento"] as! String)
                        self.premio.text = (json["resultado"]![0]["premio"] as! String)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func toMenu(sender: AnyObject) {
        let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let registroPantalla = nuestroStoryBoard.instantiateViewControllerWithIdentifier("NavigationSeleccion") as! MenuMyNavigationController
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(registroPantalla, animated:true, completion: nil)
        })
        
    }
    
    @IBAction func toCompartir(sender: AnyObject) {
        let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let registroPantalla = nuestroStoryBoard.instantiateViewControllerWithIdentifier("NavRegistroExitoso") as! VincularMyNavigationController
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(registroPantalla, animated:true, completion: nil)
        })
    }
    
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        
        toggleSideMenuView()
        
    }
    /*@IBAction func toggleSideMenu(sender: AnyObject) {
    toggleSideMenuView()
    }*/
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        print("sideMenuShouldOpenSideMenu")
        return true
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }
}