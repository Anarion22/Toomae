//
//  SearchNamesCell.swift
//  Toomae
//
//  Created by Matija Sabljak on 07/02/2017.
//  Copyright © 2017 Matija Sabljak. All rights reserved.
//

import UIKit

class SearchNamesCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var followButton: UIButton!
    
    var follow = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        followButton.setTitle("FOLLOW", for: .normal)
        
        followButton.setTitleColor( UIColor.brown, for: .normal )
        followButton.setTitleColor(UIColor.white, for: .highlighted)
        followButton.setTitleColor(UIColor.white, for: .selected)
        followButton.layer.borderWidth = 1
        followButton.layer.cornerRadius = 5.0
        followButton.layer.borderColor = UIColor.brown.cgColor
        
        
        // Initialization code
    }

    @IBAction func follow(_ sender: UIButton) {
        
        
        
        if (follow){
             print("Follow")
             followButton.setTitle("FOLLOWING", for: .normal)
            follow = false
            followButton.backgroundColor = UIColor.blue
            
        }
        
        else  {
            
             followButton.setTitle("FOLLOW", for: .normal)
            followButton.backgroundColor = UIColor.white
            
            follow = true
            print("UnFollow")
        }
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
