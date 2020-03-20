//
//  FeedTableViewCell.swift
//  InstagramApp
//
//  Created by MacBook Pro  on 18/3/20.
//  Copyright © 2020 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UIButton!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var likesCountLabel: UILabel!
    
    @IBOutlet weak var postCommnetLabel: UILabel!
    
    @IBOutlet weak var commnetCountBtn: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.masksToBounds = true
        selectionStyle = UITableViewCell.SelectionStyle.none
        
        
    }

    func updateView(post : Post) {
        profileImage.image = post.user.profileImage
        userName.setTitle(post.user.name, for: .normal)
        postImage.image = post.postImage
        likesCountLabel.text = "\(post.likesCount) likes"
        postCommnetLabel.text = post.postComment
        commnetCountBtn.setTitle("View all \(post.commentCount)", for: .normal)
        dateLabel.text = post.datePosted
        
    }
    
}
