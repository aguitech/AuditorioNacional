//
//  ViewController.swift
//  SwiftSideMenu


import UIKit

class ViewControllerMenu: UIViewController, ENSideMenuDelegate {
    
    var color = UIColor(red: 0.234375, green: 0.74609375, blue: 0.6640625, alpha: 1.0)
    
    @IBOutlet weak var informacion: UITextView!
    @IBOutlet weak var informacion2: UITextView!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var imagen2: UIImageView!
    
    
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
    func load_image2(urlString:String)
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
                    self.imagen2.image = UIImage(data: data!)
                }
                
                dispatch_async(dispatch_get_main_queue(), display_image)
            }
            
        }
        
        task.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.tintColor = color
        
        self.sideMenuController()?.sideMenu?.delegate = self
        
        
        
        //let ciudad = ciudadTextField.text
        //let appId = "455f3e37d059268550863c04efcc9805"
        //let apiUrl = "http://api.openweathermap.org/data/2.5/forecast/weather?q=\(ciudad!)&APPID=\(appId)" + "&es&lang=sp"
        
        self.informacion.text = "Hola"
        
        let apiUrl = "http://emocionganar.com/admin/panel/webservice_blog.php"
        
        
        
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
                    
                    let arregloJsonList = jsonCompleto["blog"]
                    
                    print("Funciona")
                    
                    print("Arreglo JsonWeather\(arregloJsonList)")
                    
                    if let nsArrayJsonList = arregloJsonList as? NSArray{
                        
                        //Itinerar por todo nuestro arregloJsonList
                        
                        nsArrayJsonList.enumerateObjectsUsingBlock({ objeto, index, stop in
                            print("Funciona de nuevo")
                            
                            print(objeto)
                            print("Funciona otra vez")
                            print(objeto["descripcion"])
                            
                            /**
                            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                            var test =  UIImage(data: NSData(contentsOfURL: NSURL(string:"http://devhumor.com/wp-content/uploads/2012/04/devhumor.com_pointers.png")!)!)
                            })
                            */
                            /*
                            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                            
                            var myImage =  UIImage(data: NSData(contentsOfURL: NSURL(string:"http://upload.wikimedia.org/wikipedia/en/4/43/Apple_Swift_Logo.png")!))
                            })
                            */
                            
                            /*
                            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                            var profilePic =  UIImage(data: NSData(contentsOfURL: NSURL(string:"http://devhumor.com/wp-content/uploads/2012/04/devhumor.com_pointers.png")!)!);
                            
                            self.imagen.setImage(profilePic);
                            });
                            */
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                if index==0{
                                    let descripcion = objeto["descripcion"] as! String
                                    self.informacion.text = descripcion
                                    let imagen_url = objeto["imagen"] as! String
                                    //self.load_image("http://www.kaleidosblog.com/tutorial/kaleidosblog.png")
                                    //self.load_image("http://enobra.com.mx/images/Imagen2.jpg")
                                    self.load_image("\(imagen_url)")
                                    
                                }
                                if index==1{
                                    let descripcion = objeto["descripcion"] as! String
                                    self.informacion2.text = descripcion
                                    let imagen_url = objeto["imagen"] as! String
                                    self.load_image2("\(imagen_url)")
                                }
                                
                            })
                            
                            //let descripcion = objeto["description"] as! String
                            //print("Descripcion:\(descripcion)")
                            /*
                            if index == 0 {
                            let arreglosClima = objeto["weather"] as! NSArray
                            print("Primer Clima:\(arreglosClima)")
                            
                            //Itinerar por todo nuestro arreglo weather
                            arreglosClima.enumerateObjectsUsingBlock({ objeto, index, stop in
                            
                            if index == 0 {
                            let descripcion = objeto["description"] as! String
                            print("Descripcion:\(descripcion)")
                            
                            dispatch_async(dispatch_get_main_queue(), {
                            //self.informacion.text = descripcion
                            } )
                            
                            
                            
                            
                            
                            }
                            })
                            }
                            */
                            
                            
                        })
                    }
                    /*
                    if let nsArrayJsonList = arregloJsonList as? NSArray{
                    
                    //Itinerar por todo nuestro arregloJsonList
                    
                    nsArrayJsonList.enumerateObjectsUsingBlock({ objeto, index, stop in
                    
                    if index == 0 {
                    let arreglosClima = objeto["weather"] as! NSArray
                    print("Primer Clima:\(arreglosClima)")
                    
                    //Itinerar por todo nuestro arreglo weather
                    arreglosClima.enumerateObjectsUsingBlock({ objeto, index, stop in
                    
                    if index == 0 {
                    let descripcion = objeto["description"] as! String
                    print("Descripcion:\(descripcion)")
                    
                    dispatch_async(dispatch_get_main_queue(), {
                    //self.informacion.text = descripcion
                    } )
                    
                    
                    
                    
                    
                    }
                    })
                    }
                    
                    
                    })
                    }
                    */
                    
                }catch{
                    
                    print("Error al serializar Json")
                }
            }
            
            /*
            if(error != nil) {
            // Imprimir descripcion del error si es que error NO esta vacio
            print(error!.localizedDescription)
            }else{
            
            let nsdata:NSData = NSData(data: data!)
            
            //print(nsdata)
            
            do{
            
            let jsonCompleto = try NSJSONSerialization.JSONObjectWithData( nsdata, options: NSJSONReadingOptions.MutableContainers)
            
            
            print("Json Completo\(jsonCompleto)")
            
            let arregloJsonList = jsonCompleto["list"]
            
            print("Arreglo JsonWeather\(arregloJsonList)")
            
            if let nsArrayJsonList = arregloJsonList as? NSArray{
            
            //Itinerar por todo nuestro arregloJsonList
            
            nsArrayJsonList.enumerateObjectsUsingBlock({ objeto, index, stop in
            
            if index == 0 {
            let arreglosClima = objeto["weather"] as! NSArray
            print("Primer Clima:\(arreglosClima)")
            
            //Itinerar por todo nuestro arreglo weather
            arreglosClima.enumerateObjectsUsingBlock({ objeto, index, stop in
            
            if index == 0 {
            let descripcion = objeto["description"] as! String
            print("Descripcion:\(descripcion)")
            
            dispatch_async(dispatch_get_main_queue(), {
            //self.informacion.text = descripcion
            } )
            
            
            
            
            
            }
            })
            }
            
            
            })
            }
            
            }catch{
            
            print("Error al serializar Json")
            }
            
            
            
            
            }
            */
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


