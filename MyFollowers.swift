//
//  MyFollowers.swift
//  Toomae
//
//  Created by Matija Sabljak on 07/02/2017.
//  Copyright © 2017 Matija Sabljak. All rights reserved.
//

import UIKit

class MyFollowers: UIViewController {

    @IBOutlet weak var segmentedView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    var followingVC : FollowingVC!
    
    var followersVC : FollowersVC!
    
    var viewControllers : [UIViewController]!
    
    var selectedSegment = 0
    
    var mySegmentedControl = UISegmentedControl(items: ["FOLLOWING","FOLLOWERS"])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        followingVC = FollowingVC(nibName: "FollowingVC", bundle: nil)
        followersVC = FollowersVC(nibName: "FollowersVC", bundle: nil)
        
        viewControllers = [followingVC,followersVC]

        mySegmentedControl.setTitleTextAttributes([NSFontAttributeName:UIFont(name:"Helvetica Neue", size:13.0)!,NSForegroundColorAttributeName:UIColor.init(red: 19/255.0, green: 162/255.0, blue: 155/255.0, alpha:1.0)], for:UIControlState.normal)
        
        mySegmentedControl.setTitleTextAttributes([NSFontAttributeName:UIFont(name:"Helvetica Neue", size:13.0)!,NSForegroundColorAttributeName:UIColor.white], for:UIControlState.selected)
        
        
        mySegmentedControl.setDividerImage(self.imageWithColor(color: UIColor.white), forLeftSegmentState: UIControlState.normal, rightSegmentState: UIControlState.normal, barMetrics: UIBarMetrics.default)
        
        mySegmentedControl.setBackgroundImage(self.imageWithColor(color: UIColor.white), for:UIControlState.normal, barMetrics:UIBarMetrics.default)
        
        //mySegmentedControl.setBackgroundImage(self.imageWithColor(color: UIColor.white), for:UIControlState.selected, barMetrics:UIBarMetrics.default);
        
        mySegmentedControl.setBackgroundImage(self.imageWithColor(color: UIColor.init(red: 19/255.0, green: 162/255.0, blue: 155/255.0, alpha:1.0)), for:UIControlState.selected, barMetrics:UIBarMetrics.default);
        
        
        let frame = segmentedView.bounds
        
        let globalPoint = segmentedView.superview?.convert(segmentedView.frame.origin, to: nil)
        
        
        mySegmentedControl.frame = CGRect(x: frame.minX, y: (globalPoint?.y)!, width: frame.width, height: frame.height)
        
        mySegmentedControl.layer.cornerRadius = 5.0
        
        
        mySegmentedControl.selectedSegmentIndex = selectedSegment
        
        
        mySegmentedControl.addTarget(self, action: #selector(AddVC.segmentedValueChanged(_:)), for: .valueChanged)
        
        self.view.addSubview(mySegmentedControl)
        
        segmentedValueChanged(mySegmentedControl)
        
        
        
    }
    
    func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        
        
        
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
        
        let previusSegment = selectedSegment
        
        selectedSegment = sender.selectedSegmentIndex
        
        let previousVC = viewControllers[previusSegment]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        let vc  = viewControllers[selectedSegment]
        addChildViewController(vc)
        
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        
        vc.didMove(toParentViewController: self)
    }
    
    
    func imageWithColor(color: UIColor) -> UIImage {
        
        let rect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: mySegmentedControl.frame.size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
        
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
