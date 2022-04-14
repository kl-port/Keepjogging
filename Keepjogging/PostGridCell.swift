//
//  PostGridCell.swift
//  Keepjogging
//
//  Created by Uyen Thuc Tran on 4/10/22.
//

import UIKit
import Parse

class PostGridCell: UICollectionViewCell {
    
    @IBOutlet weak var PostView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    
    func setup(with post: PFObject){
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url
        let url = URL(string: urlString!)
        PostView.af.setImage(withURL: url!)
        let day = String(post["countDays"] as! Int)
        let postDay = "Day "+day
        dayLabel.text = postDay
        dayLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        //PostView.layer.cornerRadius = 70
    }
    
}

