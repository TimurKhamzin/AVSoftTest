//
//  HumanTableViewCell.swift
//  AVSoftTest
//
//  Created by Timur Khamzin on 08.03.2020.
//  Copyright © 2020 Timur Khamzin. All rights reserved.
//

import UIKit
import RealmSwift

class HumanTableViewCell: UITableViewCell {

    static let reuseID = "HumanTableViewCell"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        self.backgroundColor = .clear
        avatarView.clipsToBounds = true
        avatarView.backgroundColor = .clear
        avatarView.layer.cornerRadius = avatarView.frame.height / 2
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
