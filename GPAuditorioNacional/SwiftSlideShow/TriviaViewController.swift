//
//  TriviaViewController.swift
//  Comparte tu Experiencia
//
//  Created by Gerardo Canseco Montiel on 10/02/16.
//  Copyright © 2016 Aguitech. All rights reserved.
//

import UIKit

class TriviaViewController : UIViewController{
    
    @IBOutlet weak var contador: UILabel!
    @IBOutlet weak var pregunta: UILabel!
    @IBOutlet weak var respuesta1Btn: UIButton!
    @IBOutlet weak var respuesta2Btn: UIButton!
    @IBOutlet weak var respuesta3Btn: UIButton!
    @IBOutlet weak var respuesta4Btn: UIButton!
    
    var seconds = 60
    var timer = NSTimer()
    var timeIsOn = false
    var pregunta_actual = 0
    var respuestas_correctas = 0
    var respuestas : String = String()
    
     var arreglo_trivia : [Trivia] = [Trivia]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Agregar logo como título
        let logo = UIImage(named: "titulo_be_part_of")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
        //Esconde Boton hacia atras
        self.navigationItem.hidesBackButton = true
        
        comenzarAutomaticamente()
    }//Fin de la función ViewDidLoad
    
    //La función comenzarAutomaticamente crea un timer
    func comenzarAutomaticamente() {
        if(timeIsOn == false){
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("actualizarTimer"), userInfo: nil, repeats: true)
            timeIsOn = true
        }
    }//Fin de funcion comenzarAutomaticamente
    
    
    //Funcion selector para el timer
    func actualizarTimer(){
        seconds--
        contador.text = "\(seconds)"
        
        
        if(self.pregunta_actual == arreglo_trivia.count){
            timer.invalidate()
            self.performSegueWithIdentifier("hacia_post_trivia", sender: self)
        }
        
        if(self.pregunta_actual < arreglo_trivia.count){
        self.pregunta.text = self.arreglo_trivia[self.pregunta_actual].pregunta
        respuesta1Btn.setTitle("\(arreglo_trivia[pregunta_actual].respuesta1)", forState: UIControlState.Normal)
        respuesta2Btn.setTitle("\(arreglo_trivia[pregunta_actual].respuesta2)", forState: UIControlState.Normal)
        respuesta3Btn.setTitle("\(arreglo_trivia[pregunta_actual].respuesta3)", forState: UIControlState.Normal)
        respuesta4Btn.setTitle("\(arreglo_trivia[pregunta_actual].respuesta4)", forState: UIControlState.Normal)
        
        print("valor de pregunta actual: \(self.pregunta_actual)")
        
        print("arreglo_trivia.count: \(arreglo_trivia.count - 1)")
        }
        
        if(seconds == 5){
            contador.textColor = UIColor.redColor()
        }
        if(seconds == 0){
            timer.invalidate()
            /*let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
            let registroPantalla = nuestroStoryBoard.instantiateViewControllerWithIdentifier("pantalla_siguiente") as! PantallaSiguiente
            
            dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(registroPantalla, animated:true, completion: nil)
            })*/
            
            self.performSegueWithIdentifier("hacia_post_trivia", sender: self)
        }
        
        
    }//Fin de funcion actualizarTimer
    
    //Funcion que realiza un acción al oprimir algún boton de respuesta
    @IBAction func OprimirBoton(sender: UIButton) {
        
        /*if(arreglo_trivia[pregunta_actual].respesta_correcta == sender.restorationIdentifier!){
        respuestas_correctas++
        }*/
        
        respuestas = respuestas + arreglo_trivia[pregunta_actual].id_pregunta + ","
        
        switch sender.restorationIdentifier!{
        case "respuesta1":
            respuestas = respuestas + arreglo_trivia[pregunta_actual].id_respuesta1 + ";"
        case "respuesta2":
            respuestas = respuestas + arreglo_trivia[pregunta_actual].id_respuesta2 + ";"
        case "respuesta3":
            respuestas = respuestas + arreglo_trivia[pregunta_actual].id_respuesta3 + ";"
        case "respuesta4":
            respuestas = respuestas + arreglo_trivia[pregunta_actual].id_respuesta4 + ";"
        default:
            print("No pasa nada")
        }//Fin de switch
        
        pregunta_actual++
        print(respuestas)
        //print("\(sender.restorationIdentifier!)")
        
    }//Fin de la función OprimirBoton
    
    //Función que prepara la variable para la siguiente pantalla
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let objetoView : PostTriviaViewController = segue.destinationViewController as! PostTriviaViewController
        print("----------------------\(self.respuestas)")
        objetoView.respuestas_post = self.respuestas
        objetoView.tiempo_segundos = self.seconds
        
        /*let objetoView : PantallaSiguiente = segue.destinationViewController as! PantallaSiguiente
        objetoView.*/
    }

}