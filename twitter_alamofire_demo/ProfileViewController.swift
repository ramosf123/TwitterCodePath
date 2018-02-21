//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Farid Ramos on 2/19/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var headerImg: UIImageView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var sreenLbl: UILabel!
    @IBOutlet weak var tweetCountLbl: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerImg.af_setImage(withURL: (User.current?.headingImg)!)
        userImg.af_setImage(withURL: (User.current?.avatarImg)!)
        userLbl.text = User.current?.name
        sreenLbl.text = "@\(User.current?.screenName ?? "")"
        tweetCountLbl.text = "\(User.current?.tweetCount ?? 0)"
        followersCount.text = "\(User.current?.followers ?? 0)"
        followingCount.text = "\(User.current?.following ?? 0)"

        userImg.layer.cornerRadius = 5.0
        userImg.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
