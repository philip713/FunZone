//
//  NoteTableViewCell.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-05.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var noteCellLabel: UILabel!
    let username : String = ""
    let noteTitle : String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
