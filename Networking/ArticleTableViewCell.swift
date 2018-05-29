//
//  ArticleTableViewCell.swift
//  Networking
//
//  Created by Miguel Angel Adan Roman on 26/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    var customImageUrl: String?
    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        customImageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
