//
//  User.swift
//  Toomae
//
//  Created by Matija Sabljak on 03/02/2017.
//  Copyright © 2017 Matija Sabljak. All rights reserved.
//

import UIKit

class User : NSObject {
    var name : String?
    
    var webs : [String : String]?
    
    var socialMedias : [String : String]?
    
    //init(name : String) {
        
    //    self.name = name
    //}
    
    func setName(name: String){
        self.name = name
    }
    
    func getName()-> String{
        return self.name!
    }
}
