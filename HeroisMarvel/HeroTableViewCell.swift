//
//  HeroTableViewCell.swift
//  HeroisMarvel
//
//  Created by Thiago Antonio Ramalho on 12/01/21.
//  Copyright © 2021 Eric Brito. All rights reserved.
//

import UIKit
import Kingfisher

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var ivThumb: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func prepareCell(with hero: Hero) {
        lbName.text = hero.name
        lbDescription.text = hero.description
        ivThumb.image = nil
        
        if let url = URL(string: hero.thumbnail.fullPath) {
            ivThumb.kf.indicatorType = .activity
            ivThumb.kf.setImage(with: url)
            ivThumb.layer.cornerRadius = ivThumb.frame.size.height / 2
            ivThumb.layer.borderColor = UIColor.red.cgColor
            ivThumb.layer.borderWidth = 2
        }
    }
}
