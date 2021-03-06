
//
//  MyMenuTableViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny Nazarov on 29.09.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit

class MyMenuTableViewController: UITableViewController {
    var selectedMenuItem : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL")
        
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.darkGrayColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
            cell!.textLabel?.textColor = UIColor.whiteColor()
            
        }
        
        //cell!.textLabel?.text = "ViewController #\(indexPath.row+1)"
        if(indexPath.row == 0){
            /*let nombreDefault = NSUserDefaults.standardUserDefaults()
            
            if (nombreDefault.valueForKey("nombre") != nil){
                let nombre = nombreDefault.valueForKey("nombre") as! String
                cell!.textLabel?.text = nombre
            }*/
            
            cell!.textLabel?.text = "Blog"
            
            
        }
        if(indexPath.row == 1){
            cell!.textLabel?.text = "Eventos"
        }
        if(indexPath.row == 2){
            cell!.textLabel?.text = "Trivias"
        }
        if(indexPath.row == 3){
            cell!.textLabel?.text = "Ganadores"
        }
        if(indexPath.row == 4){
            cell!.textLabel?.text = "¿Cómo participar?"
        }
        if(indexPath.row == 5){
            cell!.textLabel?.text = "Compatir"
        }
        if(indexPath.row == 6){
            cell!.textLabel?.text = "Terminos y Condiciones"
        }
        if(indexPath.row == 7){
            cell!.textLabel?.text = "Aviso de Privacidad"
        }
        if(indexPath.row == 8){
            cell!.textLabel?.text = "Contacto"
        }
        if(indexPath.row == 9){
            cell!.textLabel?.text = "Salir"
            //Para cerrar sesión
            //cell!.textLabel?.text = "Cerrar sesión"
        }
        
        
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("did select row: \(indexPath.row)")
        
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (indexPath.row) {
        case 0:
            //Blog
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController1")
            break
        case 1:
            //Eventos
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("tableEvento")
            break
        case 2:
            //Trivia
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController3")
            break
        case 3:
            //Ganadores
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ganadores")
            break
        case 4:
            //Como participar
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("nuevo_como_participar")
            break
        case 5:
            //Compatir
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("NavRegistroExitoso")
            break
        case 6:
            //Terminos y Condiciones
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController4")
        case 7:
            //Aviso de privacidad
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController5")
            break
            
        case 8:
            //Contacto
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("contacto")
            break
        //Cerrar Sesión
        case 9:
            exit(0)
            //Para cerrar sesión
            /*print("Entra a esta parte 2")
            let nombreDefault = NSUserDefaults.standardUserDefaults()
            nombreDefault.setValue(nil, forKey: "usuario")
            nombreDefault.setValue(nil, forKey: "id")
            nombreDefault.setValue(nil, forKey: "nombre")
            nombreDefault.synchronize()
            
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewInicio")
            break
            */
        default:
            print("Entra a esta parte default")
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController4")
            break
        }
            self.presentViewController(destViewController, animated: true, completion: nil)
        /*
        sideMenuController()?.setContentViewController(destViewController)
*/
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
