//
//  MessageCell.swift
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messagePP: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageFromPP: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageView.layer.cornerRadius = messageView.frame.size.height / 5    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
