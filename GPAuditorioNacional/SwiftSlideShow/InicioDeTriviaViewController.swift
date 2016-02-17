//
//  ViewController2.swift
//  SwiftSideMenu
//
//  Created by Evgeny on 01.02.15.
//  Copyright (c) 2015 Evgeny Nazarov. All rights reserved.
//



import UIKit

class InicioDeTriviaViewController: UIViewController, ENSideMenuDelegate {
    
    var arreglo_trivia : [Trivia] = [Trivia]()
    
    @IBOutlet weak var btnIniciarOutlet: UIButton!
    
    var color = UIColor(red: 0.234375, green: 0.74609375, blue: 0.6640625, alpha: 1.0)
    var color_fondo_navbar = UIColor(red: (10/255), green: (20/255), blue: (38/255), alpha: 1.0)
    
    //La función view DidLoad comienza con la ejecuación del programa
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-----------------------------------------------------------------------------------------------------------------------")
        //Cambiar Color
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.barTintColor = color_fondo_navbar
        
        //Poner imagen como titulo
        let logo = UIImage(named: "titulo_be_part_of")
        let imageView = UIImageView (image: logo)
        self.navigationItem.titleView = imageView
        
        self.sideMenuController()?.sideMenu?.delegate = self
        
        
    }//Fin de la función ViewDidLoad
    
    //Necesitamos la función viewDidAppear para mostrar las alertas
    override func viewDidAppear(animated: Bool) {
        if Reachability.isConnectedToNetwork() == false {
            let alertController = UIAlertController(title: "Conexión fallida", message:
                "Necesitas conexión a internet para poder participar en la trivia.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            let apiUrl = "http://emocionganar.com/admin/panel/webservice_trivia.php"
            
            
            
            //Llamada
            let url = NSURL(string: apiUrl)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
                if(error != nil) {
                    // Imprimir descripcion del error si es que error NO esta vacio
                    print(error!.localizedDescription)
                }else{
                    let nsdata:NSData = NSData(data: data!)
                    
                    do{
                        
                        let jsonCompleto = try NSJSONSerialization.JSONObjectWithData( nsdata, options: NSJSONReadingOptions.MutableContainers)
                        
                        
                        //print("Json Completo\(jsonCompleto)")
                        
                        let arregloJsonList = jsonCompleto["trivia"]
                        
                        //print("Arreglo JsonWeather\(arregloJsonList)")
                        
                        if let nsArrayJsonList = arregloJsonList as? NSArray{
                            
                            //Itinerar por todo nuestro arregloJsonList
                            
                            nsArrayJsonList.enumerateObjectsUsingBlock({ objeto, index, stop in
                                
                                
                                dispatch_async(dispatch_get_main_queue(), {
                                    
                                    for(var i = 0 ; i < nsArrayJsonList.count ; i++){
                                        if(index == i){
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
                                            
                                            self.arreglo_trivia.append(trivia_ayuda)
                                            
                                            print("\(trivia_ayuda.id_pregunta)")
                                            print("\(trivia_ayuda.pregunta)")
                                            print("\(trivia_ayuda.respuesta1)")
                                            print("\(trivia_ayuda.respuesta2)")
                                            print("\(trivia_ayuda.respuesta3)")
                                            print("\(trivia_ayuda.respuesta4)")
                                            
                                        }
                                        if(nsArrayJsonList.count - 1 == index){
                                            UIView.animateWithDuration(0.5, animations: { () -> Void in
                                                self.btnIniciarOutlet.alpha = 1.0
                                            })
                                        }
                                    }
                                    print(self.arreglo_trivia)
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
                    }catch{
                        
                        print("Error al serializar Json")
                    }
                }
            })
            task.resume()
        }
    }//Fin de la función ViewDidAppear
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        
        toggleSideMenuView()
        
    }
    
    @IBAction func toMenu(sender: AnyObject) {
        let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let registroPantalla = nuestroStoryBoard.instantiateViewControllerWithIdentifier("NavigationSeleccion") as! MenuMyNavigationController
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(registroPantalla, animated:true, completion: nil)
        })

    }//Fin de la funcion to Menu
    
    
    @IBAction func iniciar(sender: AnyObject) {
        self.performSegueWithIdentifier("hacia_trivia", sender: self)

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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
            let objetoView : TriviaViewController = segue.destinationViewController as! TriviaViewController
            objetoView.arreglo_trivia = self.arreglo_trivia

    }
}