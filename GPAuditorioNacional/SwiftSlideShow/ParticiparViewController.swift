//
//  ViewController.swift
//  SwiftSlideShow
//
//  Created by Malek T. on 4/13/15.
//  Copyright (c) 2015 Medigarage Studios LTD. All rights reserved.
//

import UIKit

class ParticiparViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet weak var logoImagen: UIImageView!
    @IBOutlet weak var logoTextoImagen: UIImageView!
    
    @IBOutlet weak var btnComenzar: UIButton!
    
    var color = UIColor(red: 0.234375, green: 0.74609375, blue: 0.6640625, alpha: 1.0)
    var color_fondo_navbar = UIColor(red: (10/255), green: (20/255), blue: (38/255), alpha: 1.0)
    //    @IBOutlet var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Cambio de color
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.barTintColor = color_fondo_navbar
        
        //Agregar imagen como titulo
        let logo = UIImage(named: "titulo_be_part_of")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
        
            
        
        //1
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.maxY)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.maxY
        //2
        textView.textAlignment = .Center
        textView.text = ""
        textView.textColor = .blackColor()
        logoImagen.image = nil
        logoTextoImagen.image = nil
        
        //        self.startButton.layer.cornerRadius = 4.0
        //3
        let imgOne = UIImageView(frame: CGRectMake(0, 0,scrollViewWidth, scrollViewHeight))
        imgOne.image = UIImage(named: "Slide2 1")
        let imgTwo = UIImageView(frame: CGRectMake(scrollViewWidth, 0,scrollViewWidth, scrollViewHeight))
        imgTwo.image = UIImage(named: "Slide2 2")
        let imgThree = UIImageView(frame: CGRectMake(scrollViewWidth*2, 0,scrollViewWidth, scrollViewHeight))
        imgThree.image = UIImage(named: "Slide2 3")
        let imgFour = UIImageView(frame: CGRectMake(scrollViewWidth*3, 0,scrollViewWidth, scrollViewHeight))
        imgFour.image = UIImage(named: "Slide 4")
        
        self.scrollView.addSubview(imgOne)
        self.scrollView.addSubview(imgTwo)
        self.scrollView.addSubview(imgThree)
        //self.scrollView.addSubview(imgFour)
        //4
        //        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 4, self.scrollView.frame.height)
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 3, self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
    }
    
    
    @IBAction func iniciarRegistro(sender: UIButton) {
        let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let registroPantalla = nuestroStoryBoard.instantiateViewControllerWithIdentifier("pantallaRegistro") as! RegistroController
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(registroPantalla, animated:true, completion: nil)
        })
    }
    
    /**
     @IBAction func cambiarRegistro(sender: UIButton) {
     print("Dentro del boton")
     let nuestroStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
     
     let pantallaRegistro = nuestroStoryBoard.instantiateViewControllerWithIdentifier("") as! RegistroController
     
     self.presentViewController(pantallaRegistro, animated: true, completion:nil)
     }
     */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    //MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
        /*if Int(currentPage) == 0{
            //textView.text = "Sweettutos.com is your blog of choice for Mobile tutorials"
            textView.text = ""
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.btnComenzar.alpha = 0
            })
        }else if Int(currentPage) == 1{
            //textView.text = "I write mobile tutorials mainly targeting iOS"
            textView.text = ""
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.btnComenzar.alpha = 0
            })
        }else if Int(currentPage) == 2{
            //textView.text = "And sometimes I write games tutorials about Unity"
            textView.text = ""
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.btnComenzar.alpha = 1.0
            })
            /*
            UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.startButton.alpha = 1.0
            })
            */
        }else{
            //textView.text = "Keep visiting sweettutos.com for new coming tutorials, and don't forget to subscribe to be notified by email :)"
            textView.text = ""
            
        }*/
        // Show the "Let's Start" button in the last slide (with a fade in animation)
        
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

