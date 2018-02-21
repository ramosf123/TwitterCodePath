//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Farid Ramos on 2/19/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var screenNameLbl: UILabel!
    @IBOutlet weak var tweetField: UITextView!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var tweetBtn: UIBarButtonItem!
    
    var delegate: ComposeViewControllerDelegate?
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetField.delegate = self
        userImg.af_setImage(withURL: (User.current?.avatarImg)!)
        userNameLbl.text = User.current?.name
        screenNameLbl.text = "@\(User.current?.screenName ?? "")"
        userImg.layer.cornerRadius = 5.0
        userImg.clipsToBounds = true
        }
    

    @IBAction func onTapCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didTapPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetField.text!) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let count = tweetField.text.count
        if count > 140 || count <= 0 {
            tweetBtn.isEnabled = false
            countLbl.textColor = .red
        } else {
            tweetBtn.isEnabled = true
            countLbl.textColor = .black
        }
        
        countLbl.text = "\(count)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
