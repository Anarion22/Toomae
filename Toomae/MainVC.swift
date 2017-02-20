//
//  HomeVC.swift
//  Toomae
//
//  Created by Matija Sabljak on 03/02/2017.
//  Copyright © 2017 Matija Sabljak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MainVC: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet var buttons: [UIButton]!
    
  
    
    
    @IBOutlet weak var searchButton: UIButton!
    
    
    var myProfileVC : MyProfile!
    
    var myFollowersVC : MyFollowers!
    
    var settingsVC : Settings!
    
    var searchNamesVC : SearchNamesVC!
    
    var shareVC : ShareVC!
    
    var viewControllers : [UIViewController]!
    
    var newIcon: Icon? {
        didSet{
            (myProfileVC as MyProfile).newIcon = newIcon
            (myProfileVC as MyProfile).collectionView.reloadData()
        }
    }
    
   
    
    var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       

        myProfileVC = MyProfile(nibName: "MyProfile", bundle: nil)
        myFollowersVC = MyFollowers(nibName: "MyFollowers", bundle: nil)
        settingsVC = Settings(nibName: "Settings", bundle: nil)
        searchNamesVC = SearchNamesVC(nibName: "SearchNamesVC", bundle: nil)
        shareVC = ShareVC(nibName: "ShareVC", bundle: nil)
        
        viewControllers = [myProfileVC,myFollowersVC,shareVC,settingsVC]
        
        buttons[selectedIndex].isSelected = true
        
        didPressTab(buttons[selectedIndex])
        
        print("asdapsok")
        

    }

    
    @IBAction func logOut(_ sender: UIButton) {
        
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                let loginView = LoginView(nibName: "LoginView", bundle: nil)
                self.present(loginView, animated: true, completion: nil)

                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

    @IBAction func didPressTab(_ sender: UIButton) {
        
       
        
        let previousIndex = selectedIndex
        
        selectedIndex = sender.tag
        
        buttons[previousIndex].isSelected = false
        
        let previousVC = viewControllers[previousIndex]
        
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        sender.isSelected = true
        let vc = viewControllers[selectedIndex]
        addChildViewController(vc)
        
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        
        vc.didMove(toParentViewController: self)

    }


    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
        self.present(searchNamesVC, animated: true, completion: nil)
        
  
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
