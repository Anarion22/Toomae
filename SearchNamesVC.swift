//
//  SearchNamesVC.swift
//  Toomae
//
//  Created by Matija Sabljak on 07/02/2017.
//  Copyright © 2017 Matija Sabljak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SearchNamesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var nameList: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var ref: FIRDatabaseReference!
    var refHandle : UInt!
    
    var userList = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()

        nameList.delegate = self
        nameList.dataSource = self
        
        fetchUsers()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SearchNamesCell", owner: self , options: nil)?.first as! SearchNamesCell
        let row = indexPath.row
        
        cell.userName?.text = userList[row].getName()
        
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func fetchUsers(){
        
        ref.child("users").observe(.childAdded, with: { snapshot in
            
            let name = snapshot.value as? [String : AnyObject]
            
            
                let user = User()
            
                user.setName(name: name?["name"] as! String)
                
                self.userList.append(user)
                
                self.nameList.reloadData()
            
          
                
                 
                
            
        
        })
        
        
    }
    @IBAction func backTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)

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
