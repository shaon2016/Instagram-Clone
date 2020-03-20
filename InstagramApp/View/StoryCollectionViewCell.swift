//
//  StoryCollectionViewCell.swift
//  InstagramApp
//
//  Created by MacBook Pro  on 20/3/20.
//  Copyright © 2020 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit



class StoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        storyImage.layer.cornerRadius = storyImage.frame.width / 2
        storyImage.layer.masksToBounds = true

        storyImage.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        storyImage.layer.borderWidth = CGFloat(3.0)
    }

}
