//
//  ViewController.swift
//  SwiftSideMenu


import UIKit

class BlogViewController: UIViewController, ENSideMenuDelegate {
    
    var color = UIColor(red: 0.234375, green: 0.74609375, blue: 0.6640625, alpha: 1.0)
    var color_fondo_navbar = UIColor(red: (10/255), green: (20/255), blue: (38/255), alpha: 1.0)

    
    //@IBOutlet weak var informacion: UITextView!
    //@IBOutlet weak var informacion2: UITextView!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var imagen2: UIImageView!
    
    @IBOutlet weak var titulo: UILabel!
    
    @IBOutlet weak var titulo2: UILabel!
    
    @IBOutlet weak var informacion: UILabel!
    @IBOutlet weak var informacion2: UILabel!
    
    
    var id_blog_sup = String()
    var id_blog_inf = String()
    var id_a_blog = String()
    
    
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
        
        //Cambio de Color
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.barTintColor = color_fondo_navbar
        
        //Agregar Imagen como titulo
        let logo = UIImage(named: "titulo_be_part_of")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
        
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
                                    let descripcion = objeto["blog"] as! String
                                    self.informacion.text = descripcion
                                    let titulo = objeto["titulo"] as! String
                                    self.titulo.text = titulo
                                    
                                    
                                   
                                    self.id_blog_sup = objeto["id_blog"] as! String
                                    print(self.id_blog_sup)
                                    
                                    
                                    let imagen_url = objeto["imagen"] as! String
                                    //self.load_image("http://www.kaleidosblog.com/tutorial/kaleidosblog.png")
                                    //self.load_image("http://enobra.com.mx/images/Imagen2.jpg")
                                    self.load_image("\(imagen_url)")
                                    
                                    
                                }
                                if index==1{
                                    let descripcion = objeto["blog"] as! String
                                    self.informacion2.text = descripcion
                                    let titulo = objeto["titulo"] as! String
                                    self.titulo2.text = titulo
                                    
                                    
                                    dispatch_async(dispatch_get_main_queue(), {
                                        print("----------------------------------------Bandera")
                                        self.id_blog_inf = objeto["id_blog"] as! String
                                        print(self.id_blog_inf)
                                        print("----------------------------------------Bandera")
                                    
                                    })
                                    //self.titulo2.text = titulo
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

    @IBAction func entrada1(sender: AnyObject) {
        
        id_a_blog = id_blog_sup
        print("Al oprimir el boton-----------")
        print(id_a_blog)
        
        
        /*let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let nuevoView = nuestroStoryBoard.instantiateViewControllerWithIdentifier("ViewController6") as!MyNavigationController6
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(nuevoView, animated:true, completion: nil)
        })*/
        let VC1 = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController6id") as! BlogDetalleViewController
        self.navigationController!.pushViewController(VC1, animated: true)
    }
    
  
    @IBAction func entrada2(sender: AnyObject) {
        
        id_a_blog = id_blog_inf
        print("Al oprimir el boton-----------")
        print(id_a_blog)
        /*let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let nuevoView = nuestroStoryBoard.instantiateViewControllerWithIdentifier("ViewController6") as! MyNavigationController6
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(nuevoView, animated:true, completion: nil)
        })*/
        
        let VC1 = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController6id") as! BlogDetalleViewController
        self.navigationController!.pushViewController(VC1, animated: true)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController: BlogDetalleViewController = segue.destinationViewController as! BlogDetalleViewController
        print("Dentro del Segue")
        print(id_a_blog)
        destViewController.id = id_a_blog
        
    }
}


