//
//  ViewController2.swift
//  SwiftSideMenu
//
//  Created by Evgeny on 01.02.15.
//  Copyright (c) 2015 Evgeny Nazarov. All rights reserved.
//



import UIKit

class EventoViewController: UIViewController, ENSideMenuDelegate {
    
    //Relaciones con Storyboard
    @IBOutlet weak var informacion: UITextView!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var evento: UILabel!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var fecha: UILabel!

    
    //Valor para segue
    var numero_descarga : Int?
    
    //Definicion de Colores
    var color = UIColor(red: 0.234375, green: 0.74609375, blue: 0.6640625, alpha: 1.0)
    var color_fondo_navbar = UIColor(red: (10/255), green: (20/255), blue: (38/255), alpha: 1.0)

    
    func load_image(urlString:String)
    {
        let imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            if (error == nil && data != nil)
            {
                func display_image()
                {
                    self.imagen.image = UIImage(data: data!)
                }
                
                dispatch_async(dispatch_get_main_queue(), display_image)
            }
            
        }
        
        task.resume()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Cambiar colores
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.barTintColor = color_fondo_navbar
        
        //Agregar logo como título
        let logo = UIImage(named: "titulo_be_part_of")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
        
        self.sideMenuController()?.sideMenu?.delegate = self
    
        print("El numero de la descarga: \(self.numero_descarga!)")
        
        
        let apiUrl = "http://emocionganar.com/admin/panel/webservice_evento.php"
        
        
        
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
                    
                    
                    print("Json Completo\(jsonCompleto)")
                    
                    let arregloJsonList = jsonCompleto["evento"]
                    
                    print("Arreglo JsonWeather\(arregloJsonList)")
                    
                    if let nsArrayJsonList = arregloJsonList as? NSArray{
                        
                        //Itinerar por todo nuestro arregloJsonList
                        
                        nsArrayJsonList.enumerateObjectsUsingBlock({ objeto, index, stop in
                            
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                if (index == self.numero_descarga!){
                                    let descripcion = objeto["descripcion"] as! String
                                    self.informacion.text = descripcion
                                    print(descripcion)
                                    self.evento.text = objeto["evento"] as? String
                                    self.fecha.text = objeto["fecha"] as? String
                                    self.nombre.text = objeto["nombre"] as? String
                                    let imagen_url = objeto["imagen"] as! String
                                    self.load_image("\(imagen_url)")
                                }
                                
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

