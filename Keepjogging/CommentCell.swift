//
//  CommentCell.swift
//  Instagram
//
//  Created by Ken Ling on 3/30/22.
//

import UIKit

class CommentCell: UITableViewCell {



    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
