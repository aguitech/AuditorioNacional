import UIKit

class TableEventoViewController: UIViewController, ENSideMenuDelegate {
    
    var color = UIColor(red: 0.234375, green: 0.74609375, blue: 0.6640625, alpha: 1.0)
    var color_fondo_navbar = UIColor(red: (10/255), green: (20/255), blue: (38/255), alpha: 1.0)
    
    struct evento {
        var id_evento : String = String ()
        var evento : String = String ()
        var nombre : String = String ()
        var imagen : String = String ()
        var descripcion : String = String ()
        var fecha : String = String ()
        
    }
    
    var arreglo_eventos : [evento] = [evento]()
    
    @IBOutlet var tableView: UITableView!
    
    
    @IBAction func toMenuView(sender: AnyObject) {
        let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let registroPantalla = nuestroStoryBoard.instantiateViewControllerWithIdentifier("NavigationSeleccion") as! MenuMyNavigationController
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(registroPantalla, animated:true, completion: nil)
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Cambio Colores
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.barTintColor = color_fondo_navbar
        
        //Poner imagen como titulo
        let logo = UIImage(named: "titulo_be_part_of")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
        //cambiarfondo
        tableView.backgroundView = UIImageView(image: UIImage(named: "fondo.png"))
        
        self.sideMenuController()?.sideMenu?.delegate = self
        
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
                    let arregloJsonList = jsonCompleto["evento"]
                    
                    if let nsArrayJsonList = arregloJsonList as? NSArray{
                        
                        nsArrayJsonList.enumerateObjectsUsingBlock({ objeto, index, stop in dispatch_async(dispatch_get_main_queue(), {
                            
                            for(var i = 0; i < nsArrayJsonList.count; i++){
                                if(index == i){
                                    var evento_de_ayuda : evento = evento()
                                    
                                    evento_de_ayuda.id_evento = objeto["id_evento"] as! String
                                    evento_de_ayuda.evento = objeto ["evento"] as! String
                                    evento_de_ayuda.nombre = objeto["nombre"] as! String
                                    evento_de_ayuda.imagen = objeto["imagen"] as! String
                                    evento_de_ayuda.descripcion = objeto["descripcion"] as! String
                                    evento_de_ayuda.fecha = objeto["fecha"] as! String
                                    
                                    self.arreglo_eventos.append(evento_de_ayuda)
                                    
                                }
                                
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    self.tableView.reloadData()
                                })
                                
                            }
                        })
                        })
                    }
                }catch{
                    print("Error al serializar Json")
                }
            }
        })//fin task
        task.resume()
    }//Fin del método ViewDidLoad
    
    
    //Función que define el número de secciones
    func numberOfSectionInTableView(tableView : UITableView) -> Int {
        return 1
    }//Fin función numberOfSectionInTableView
    
    //Funcion que determina el numero de elementos dentro de la tableView
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return self.arreglo_eventos.count;
    }
    
    //Funcion que llena los cell
    func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
        print("dentro de cell")
        dispatch_async(dispatch_get_main_queue(), {
            cell.textLabel!.text = self.arreglo_eventos[indexPath.row].evento
            cell.detailTextLabel!.text = self.arreglo_eventos[indexPath.row].fecha
            
        })
        return cell
    }
    
    //Funcion que realiza una accion al ser pulsado el row
    func tableView(tableView : UITableView, didSelectRowAtIndexPath indexPath : NSIndexPath){
        let row_seleccionada : Int = indexPath.row
        print(row_seleccionada)
        
        self.performSegueWithIdentifier("evento_segue", sender: row_seleccionada)
        
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
        let seleccion = sender as! Int
        
        let objetoView : EventoViewController = segue.destinationViewController as! EventoViewController
        objetoView.numero_descarga = seleccion
    }
}