//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var dateCreated: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    
    var tweet: Tweet! {
        didSet {
            profilePic.af_setImage(withURL: tweet.user.avatarImg!)
            username.text = tweet.user.name
            userHandle.text = "@\(tweet.user.screenName)"
            dateCreated.text = tweet.createdAtString
            tweetText.text = tweet.text
            self.retweetCount.text = "\(tweet.retweetCount)"
            if tweet.favoriteCount != nil {
                self.favoriteCount.text = "\(tweet.favoriteCount!)"
            }
            if tweet.favorited! {
                favBtn.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            }

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profilePic.layer.cornerRadius = 5.0
        profilePic.clipsToBounds = true
    }
    @IBOutlet weak var favBtn: UIButton!
    @IBAction func onTapFavorite(_ sender: Any) {
        
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
        self.favoriteCount.text = "\(tweet.favoriteCount!)"
        if tweet.favorited! {
            favBtn.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        } else {
            favBtn.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
    }
    
    
    @IBOutlet weak var retweetBtn: UIButton!
    @IBAction func onTapRetweet(_ sender: Any) {
        if !(tweet.retweeted) {
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
                    print("Error unretweet tweet: \(error.localizedDescription)")
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
            retweetBtn.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        } else {
            retweetBtn.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
}
