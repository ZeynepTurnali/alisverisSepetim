//
//  ProductCell.swift
//  alisverisSepetim

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
