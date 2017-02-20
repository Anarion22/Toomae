//
//  LoginView.swift
//  BrandGlobe.com
//
//  Created by Matija Sabljak on 25/01/2017.
//  Copyright © 2017 Matija Sabljak. All rights reserved.
//

import UIKit

class LoginView: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    let user1 = "m"
    
    let pass1 = "a"
    
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginView.dismissKeyboard))
        
        view.addGestureRecognizer(tap)

    }
    
    @IBAction func logOut(_ sender: UIButton) {
        
        let user = username.text
        let pass = password.text
        
        
        if((user?.isEmpty)!||(pass?.isEmpty)!)
        {
            showMessage(message: "Some of fields are empty...")
            return
        }
        
        if (user == user1){
            if (pass == pass1){
                
                defaults.set(true, forKey: "isUserLoggedIn")
                defaults.synchronize()
                
                let mainVC = MainVC(nibName: "MainVC", bundle: nil)
                
                self.present(mainVC, animated: true, completion: nil)
            }
                
            else{
                showMessage(message: "password is not correct")
                return
            }
            
        }
        else{
            showMessage(message: "User name does not exist")
            return
            
        }
        
        
        
    }
    
    func showMessage(message:String)
    {
        let myAlert = UIAlertController(title: "Alert!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return false
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }  
    
}
