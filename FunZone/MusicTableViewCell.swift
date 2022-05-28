//
//  MusicTableViewCell.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var musicImg: UIImageView!
    @IBOutlet weak var musicLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
