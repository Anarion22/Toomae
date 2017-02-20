//
//  Settings.swift
//  Toomae
//
//  Created by Matija Sabljak on 07/02/2017.
//  Copyright © 2017 Matija Sabljak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class Settings: UIViewController {
    
    var ref: FIRDatabaseReference!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()

        
    }

   
    
    @IBAction func logOut(_ sender: UIButton) {
        
        let refreshAlert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if FIRAuth.auth()?.currentUser != nil {
                do {
                    try FIRAuth.auth()?.signOut()
                    let loginView = LoginView(nibName: "LoginView", bundle: nil)
                    self.present(loginView, animated: true, completion: nil)
                    
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }

        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
         refreshAlert.view.tintColor = UIColor.init(red: 19/255.0, green: 162/255.0, blue: 155/255.0, alpha:1.0)
        
        present(refreshAlert, animated: true, completion: nil)
        
       
    }

    @IBAction func changeName(_ sender: UIButton) {
        
       
        
        let storeuser : [String: AnyObject] = ["name" : "Matija" as AnyObject]
        
        
        
        ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).setValue(storeuser)
        
        
    }
   

}
