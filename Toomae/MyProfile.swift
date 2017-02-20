//
//  MyProfile.swift
//  Toomae
//
//  Created by Matija Sabljak on 07/02/2017.
//  Copyright © 2017 Matija Sabljak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class MyProfile: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var myName: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var introCollectionView: UITextView!
    
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var followingLabel: UILabel!
    
    var items : [Icon]! = []
    
    var webs : [Icon]! = []
    
    var ref: FIRDatabaseReference!
    
    var newIcon : Icon!{
        didSet{
            //items.insert(newIcon, at: 0)
        }
    }
    

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        updateDataBase()
        
        hidesBottomBarWhenPushed = false
        
        let icon = Icon()
        icon.image = "ic_plus"
        icon.title = "Add"
        icon.link = ".."
        
        
        print("...................................")
        
        
        self.items.append(icon)

        
        
        followersLabel.text = "...\(items.count)"
        
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        let bgImage = UIImageView();
        bgImage.image = UIImage(named: "bg_2");
        bgImage.contentMode = .scaleToFill
        
        
        
        self.collectionView?.backgroundView = bgImage
        
       
        let nib = UINib(nibName: "AppCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "AppCell")

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
        
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCell", for: indexPath) as! AppCell
        
        
        cell.appIcon.image = UIImage(named :items[indexPath.item].image )
        cell.appName.text =  items[indexPath.item].title

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell \(indexPath.item)")
        
        if (items[indexPath.item].title! == "Add"){
            
            let addVC = AddVC(nibName: "AddVC", bundle: nil)
            self.present(addVC, animated: true, completion: nil)
            
        }
        
        else {
            
           let url = URL(string : "http://\(items[indexPath.item].link!)")
            
           // let url = URL(string : "http://www.google.hr")
            
            print("_____________\(items[indexPath.item].title)")
    
            UIApplication.shared.open(url!)
        }
        
        followingLabel.text = "...\(items.count)"
    }


    
    @IBAction func add(_ sender: UIButton) {
        
        let addVC = AddVC(nibName: "AddVC", bundle: nil)
        self.present(addVC, animated: true, completion: nil)
    }
    
    func updateDataBase(){
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("users").child(userID!).observe(.value, with: { (snapshot) in
            
            let value = snapshot.value as? [String : AnyObject] ?? [:]
            
         //   let name = value["name"] as! String
            
            let user = User()
            
            user.name = value["name"] as? String
            
            let web = value["website"] as? [String : AnyObject]
            
            let socialMedias = value["social_medias"] as? [String : AnyObject]
            
         //   let web = value["website"] as! [String : AnyObject]
            
            for (key, value) in web! {
                print("________________________\(key): \(value)")
                user.webs = value as? [String : String]
                
                
            }
            
            for (key, value) in socialMedias! {
                print("________________________\(key): \(value)")
                user.socialMedias = value as? [String : String]
                
                
            }

            
             print("________________________\(user.name!)")
          //   print("________________________\(n)")
            
                    print("________________________\(user.webs!)")
            
            
         
            
            
            
            
        })

        
        
     
        
        ref.child("users").child(userID!).child("website").observe(.childAdded, with: { (snapshot) in
            
            let value = snapshot.value as? [String : AnyObject] ?? [:]
            
            let icon = Icon()
            
            icon.title = value["name"] as! String
            icon.link = value["link"] as! String
            icon.image = value["picture"] as! String
            
            self.webs.append(icon)
            
           // print("________________________\(value)")

            
            self.collectionView.reloadData()
            
          
            
            
        })
 
        ref.child("users").child(userID!).child("social_medias").observe(.childAdded, with: { (snapshot) in
            
            let value = snapshot.value as? [String : AnyObject] ?? [:]
            
            let icon = Icon()
            
            icon.title = value["name"] as! String
            icon.link = value["link"] as! String
            icon.image = value["picture"] as! String
            
            self.items.insert(icon, at: 0)
            
            //print("________________________\(self.webs.count)")

            
            if (self.webs.count > 0){
                
                let webicon = Icon()
                webicon.image = "ic_web"
                webicon.title = "WEB"
                webicon.link = "..."
                
                
                self.items.insert(webicon, at: 0)
                
            }
            
          
            
            self.collectionView.reloadData()
            
 
            
            
        })

 
       
        
        collectionView.reloadData()
        
        
    }


    
}
