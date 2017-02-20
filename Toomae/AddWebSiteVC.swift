//
//  AddWebSiteVC.swift
//  Toomae
//
//  Created by Matija Sabljak on 08/02/2017.
//  Copyright © 2017 Matija Sabljak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AddWebSiteVC: UIViewController {

    @IBOutlet weak var webSite: UITextField!
    
    @IBOutlet weak var nameOfWebSite: UITextField!
    
    var item: [String:String] = [:]
    
     var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginView.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        
    }

    
    @IBAction func info1(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "INFO", message: "Type your website URL", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        alert.view.tintColor = UIColor.init(red: 19/255.0, green: 162/255.0, blue: 155/255.0, alpha:1.0)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func info2(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "INFO", message: "Type in the name of your web address", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        alert.view.tintColor = UIColor.init(red: 19/255.0, green: 162/255.0, blue: 155/255.0, alpha:1.0)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addWeb(_ sender: UIButton) {
        
        if ((webSite.text?.isEmpty)!||(nameOfWebSite.text?.isEmpty)!){
            
            showMessage(message: "Some of fields are empty...")
            return
            
        }
        
        item = [
            "link" : "www.\(webSite.text!)",
            "name" : nameOfWebSite.text!,
            "picture" : "ic_web"
        ]
        
       /* let item = Icon()
        item.image = "ic_web"
        item.title = nameOfWebSite.text!
        item.link = "www.\(webSite.text!)"
        
        let store = ["link" : item.link as AnyObject ,
                     "name" : item.title as AnyObject,
                     "picture" : item.image as AnyObject]
        */
 
        let e = ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("website").childByAutoId()
        e.setValue(item)

        
       /*
        if presentingViewController is MainVC {
            
        
            (presentingViewController as! MainVC).newIcon = item
        }
 */
        
        self.dismiss(animated: true, completion: nil)

    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return false
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func showMessage(message:String)
    {
        let myAlert = UIAlertController(title: "Alert!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
