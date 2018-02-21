//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var screenName: String
    var followers: Int
    var avatarImage: String
    var avatarImg: URL?
    var following: Int
    var tweetCount: Int
    var headingURl: String
    var headingImg: URL?
    
    static var current: User?
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as! String
        followers = dictionary["followers_count"] as! Int
        avatarImage = dictionary["profile_image_url_https"] as! String
        avatarImage = avatarImage.replacingOccurrences(of: "_normal", with: "_bigger")
        avatarImg = URL(string: avatarImage)!
        following = dictionary["friends_count"] as! Int
        tweetCount = dictionary["statuses_count"] as! Int
        headingURl = dictionary["profile_banner_url"] as! String
        headingImg = URL(string: headingURl)!
    }
    
}
