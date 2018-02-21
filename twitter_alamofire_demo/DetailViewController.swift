//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Farid Ramos on 2/18/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var tweet: Tweet!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var screenNameLbl: UILabel!
    @IBOutlet weak var tweetCont: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
    @IBOutlet weak var dateCreated: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLbl.text = tweet.user.name
        screenNameLbl.text = "@\(tweet.user.screenName)"
        tweetCont.text = tweet.text
        retweetCount.text = "\(tweet.retweetCount)"
        favCount.text = "\(tweet.favoriteCount!)"
        userImg.af_setImage(withURL: tweet.user.avatarImg!)
        dateCreated.text = tweet.createdAtString

        userImg.layer.cornerRadius = 5.0
        userImg.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var retweetBtn: UIButton!
    @IBAction func onTapRetweet(_ sender: Any) {
        if !tweet.retweeted {
            tweet.retweeted = true
            tweet.retweetCount += 1
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweet tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweet the following Tweet: \n\(tweet.text)")
                    self.refreshRetweet()
                }
            }
        } else {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweet tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweet the following Tweet: \n\(tweet.text)")
                    self.refreshRetweet()
                }
            }
        }
    }
    
    func refreshRetweet() {
        self.retweetCount.text = "\(tweet.retweetCount)"
        
        if tweet.retweeted {
            self.retweetBtn.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        } else {
            self.retweetBtn.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
        
    }
    
    @IBOutlet weak var favBtn: UIButton!
    @IBAction func onTapFav(_ sender: Any) {
        if !(tweet.favorited!) {
            tweet.favorited = true
            tweet.favoriteCount! += 1
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    self.refreshFav()
                }
            }
        } else {
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    self.refreshFav()
                }
            }
            
        }
    }
    
    func refreshFav() {
        self.favCount.text = "\(tweet.favoriteCount!)"
        
        if tweet.favorited! {
            self.favBtn.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        } else {
            self.favBtn.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
    }
    
}
