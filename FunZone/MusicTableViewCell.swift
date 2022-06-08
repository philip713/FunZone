//
//  MusicTableViewCell.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-02.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var musicCellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
