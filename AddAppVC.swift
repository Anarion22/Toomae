//
//  AddAppVC.swift
//  Toomae
//
//  Created by Matija Sabljak on 08/02/2017.
//  Copyright © 2017 Matija Sabljak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AddAppVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var addAppView: UIView!
  
    @IBOutlet weak var appIcon: UIImageView!
    
    @IBOutlet weak var appURL: UILabel!
    
    @IBOutlet weak var apptextInput: UITextField!
    
    var ref: FIRDatabaseReference!
    
    private var item = Icon()
    
    var items1 = [UIImage()]
    
    var items2 = [String()]
    
    var itemsApp : [Icon]! = []
    
    override func viewWillAppear(_ animated: Bool) {
        addAppView.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let bgImage = UIImageView();
        bgImage.image = UIImage(named: "bg_2");
        bgImage.contentMode = .scaleToFill
        
      
        
        
        
        self.collectionView?.backgroundView = bgImage

        setCollection()
        
        let nib = UINib(nibName: "AppCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "AppCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsApp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCell", for: indexPath) as! AppCell
        
       

        cell.appIcon.image = UIImage(named : itemsApp[indexPath.item].image)
        cell.appName.text =  itemsApp[indexPath.item].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell \(indexPath.item)")
        
        addAppView.isHidden = false
        
        item.image = itemsApp[indexPath.item].image
        item.title = itemsApp[indexPath.item].title
        item.link = itemsApp[indexPath.item].link
        
        appIcon.image = UIImage(named : itemsApp[indexPath.item].image)
        appURL.text = itemsApp[indexPath.item].link
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        
        addAppView.isHidden = true
    }
    
    @IBAction func addApp(_ sender: UIButton) {
        
        if (apptextInput.text?.isEmpty)!{
            
            showMessage(message: "Enter User Name...")
            return
            
        }
        
        item.link = "\(item.link!)"+"\(apptextInput.text!)"
    
        
        let store = ["link" : item.link as AnyObject ,
                     "name" : item.title as AnyObject,
                     "picture" : item.image as AnyObject]
        
        
        
        
        let e = ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("social_medias").childByAutoId()
        
        e.setValue(store)
    
        
       /* if presentingViewController is MainVC {
            
            
            (presentingViewController as! MainVC).newIcon = item
        }
        */
        self.dismiss(animated: true, completion: nil)

    }
    
    func setCollection(){
        
        let icon = Icon()
        icon.image = "ic_facebook"
        icon.link = "www.facebook.com/"
        icon.title = "Facebook"
        
        itemsApp.append(icon)
        
        let icon2 = Icon()
        icon2.image = "ic_vimeo"
        icon2.link = "https://vimeo.com/"
        icon2.title = "Vimeo"
        
        itemsApp.append(icon2)
        
        let icon3 = Icon()
        icon3.image = "ic_google+"
        icon3.link = "https://plus.google.com/+"
        icon3.title = "Google Plus"
        
        itemsApp.append(icon3)
        
        
        let image1 = #imageLiteral(resourceName: "ic_facebook")
        let text1 = "Facebook"
        
        let image2 = #imageLiteral(resourceName: "ic_vimeo")
        let text2 = "Vimeo"
        
        let image3 = #imageLiteral(resourceName: "ic_google+")
        let text3 = "Google Plus"
        
       
        
        let image5 = #imageLiteral(resourceName: "ic_redit")
        let text5 = "Redit"
        
        let image7 = #imageLiteral(resourceName: "ic_tumlr")
        let text7 = "Tumblr"
        
        let image8 = #imageLiteral(resourceName: "ic_flickr")
        let text8 = "Flickr"
        
        let image9 = #imageLiteral(resourceName: "ic_twitter")
        let text9 = "Twitter"
        
        let image10 = #imageLiteral(resourceName: "ic_snapchat")
        let text10 = "Snapchat"
        
        let image11 = #imageLiteral(resourceName: "ic_youtube")
        let text11 = "Youtube"
        
        let image12 = #imageLiteral(resourceName: "ic_instagram")
        let text12 = "Instagram"
        
        let image13 = #imageLiteral(resourceName: "ic_mixcloud")
        let text13 = "Mixcloud"
        
        let image14 = #imageLiteral(resourceName: "ic_pinterest")
        let text14 = "Pinterest"
        
        let image15 = #imageLiteral(resourceName: "ic_soundcloud")
        let text15 = "SoundCloud"
        
        
        items1 = [image1,image2,image3,image5,image7,image8,image9,image10,image11,image12,image13,image14,image15]
        
        items2 = [text1,text2,text3,text5,text7,text8,text9,text10,text11,text12,text13,text14,text15]

        
        
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
