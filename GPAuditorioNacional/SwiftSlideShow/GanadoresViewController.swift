//
//  ViewController2.swift
//  SwiftSideMenu
//
//  Created by Evgeny on 01.02.15.
//  Copyright (c) 2015 Evgeny Nazarov. All rights reserved.
//



import UIKit

class GanadoresViewController: UIViewController, ENSideMenuDelegate {
    
    
    struct ganador{
        var id_resultado_trivia : String = String()
        var puntos : String = String ()
        var fecha_creacion : String = String()
        var hora_creacion : String = String()
        var nombre : String = String()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var arreglo_ganadores : [ganador] = [ganador]()
    
    //Definicion de Colores
    var color = UIColor(red: 0.234375, green: 0.74609375, blue: 0.6640625, alpha: 1.0)
    var color_fondo_navbar = UIColor(red: (10/255), green: (20/255), blue: (38/255), alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.barTintColor = color_fondo_navbar
        
        //Agregar logo como título
        let logo = UIImage(named: "titulo_be_part_of")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
        self.sideMenuController()?.sideMenu?.delegate = self
        
        //cambiarfondo
        tableView.backgroundView = UIImageView(image: UIImage(named: "trivia_color_aqua.png"))
        
        let apiUrl = "http://emocionganar.com/admin/panel/webservice_ganadores.php"
        
        
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
                    let arregloJsonList = jsonCompleto["ganador"]
                    
                    if let nsArrayJsonList = arregloJsonList as? NSArray{
                        
                        nsArrayJsonList.enumerateObjectsUsingBlock({ objeto, index, stop in dispatch_async(dispatch_get_main_queue(), {
                            
                            for(var i = 0; i < nsArrayJsonList.count; i++){
                                if(index == i){
                                    var ganador_de_ayuda : ganador = ganador()
                                    
                                    ganador_de_ayuda.id_resultado_trivia = objeto["id_resultado_trivia"] as! String
                                    ganador_de_ayuda.puntos = objeto ["puntos"] as! String
                                    ganador_de_ayuda.nombre = objeto["nombre"] as! String
                                    ganador_de_ayuda.fecha_creacion = objeto["fecha_creacion"] as! String
                                    ganador_de_ayuda.hora_creacion = objeto["hora_creacion"] as! String
                                    
                                    print(ganador_de_ayuda)
                                    self.arreglo_ganadores.append(ganador_de_ayuda)
                                    
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

    }
    
    //Función que define el número de secciones
    func numberOfSectionInTableView(tableView : UITableView) -> Int {
        return 1
    }//Fin función numberOfSectionInTableView
    
    //Funcion que determina el numero de elementos dentro de la tableView
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return self.arreglo_ganadores.count;
    }
    
    //Funcion que llena los cell
    func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor(red: 62/255, green: 198/255, blue: 175/255, alpha: 1.0)
        print("dentro de cell")
        dispatch_async(dispatch_get_main_queue(), {
            cell.textLabel!.textColor = UIColor.whiteColor()
            cell.textLabel!.text = self.arreglo_ganadores[indexPath.row].nombre
            //cell.detailTextLabel!.text = self.arreglo_ganadores[indexPath.row].hora_creacion
            cell.detailTextLabel!.text = self.arreglo_ganadores[indexPath.row].puntos
            cell.detailTextLabel!.textColor = UIColor(red: 48/255, green: 106/255, blue: 122/255, alpha: 1.0)
            
        })
        return cell
    }
    
    //Funcion que realiza una accion al ser pulsado el row
    func tableView(tableView : UITableView, didSelectRowAtIndexPath indexPath : NSIndexPath){
        let row_seleccionada : Int = indexPath.row
        print(row_seleccionada)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Accion del boton que va hacia el menu
    @IBAction func toMenu(sender: AnyObject) {
        let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let registroPantalla = nuestroStoryBoard.instantiateViewControllerWithIdentifier("NavigationSeleccion") as! MenuMyNavigationController
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(registroPantalla, animated:true, completion: nil)
        })
    }//Fin función to Menu
    
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