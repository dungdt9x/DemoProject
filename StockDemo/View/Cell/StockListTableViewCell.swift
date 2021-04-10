//
//  StockListTableViewCell.swift
//  StockDemo
//
//  Created by Do Trung Dung on 4/10/21.
//

import UIKit
import Kingfisher

class StockListTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnFav: UIButton!
    var cellModel: CellViewModel? {
        didSet {
            if (cellModel != nil && cellModel?.stock != nil) {
                lblName.text = cellModel?.stock?.name
                lblPrice.text = "\(cellModel?.stock?.currency ?? "")\(cellModel?.stock?.price ?? 0)"
                lblSymbol.text = cellModel?.stock?.symbol
                
                if (cellModel?.stock?.image != nil && cellModel?.stock?.image.count != 0) {
                    avatar.kf.setImage(with:  URL(string: cellModel?.stock?.image ?? ""))
                } else {
                    avatar.image = UIImage(named: "placeHolder")
                }
                
                if (cellModel?.stock?.isFavourite == true) {
                    self.btnFav.setImage(UIImage(named: "bookmarkSelected"), for: .normal)
                } else {
                    self.btnFav.setImage(UIImage(named: "bookmark"), for: .normal)
                }
                if ((cellModel?.stock?.changes ?? 0) > 0) {
                    self.lblPrice.textColor = .green
                } else {
                    if ((cellModel?.stock?.changes ?? 0) < 0) {
                        self.lblPrice.textColor = .red
                    } else {
                        self.lblPrice.textColor = .black
                    }
                }
                self.setNeedsLayout()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.avatar.layer.cornerRadius = 45
        self.avatar.clipsToBounds = true
        self.avatar.layer.borderWidth = 0.5
        self.avatar.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.avatar.image = UIImage(named: "placeHolder")
        self.lblName.text = nil
        self.lblPrice.text = nil
        self.lblSymbol.text = nil
    }
    
    @IBAction func selectBookmark(_ sender: Any) {
        if (cellModel != nil) {
            cellModel?.updateFav()
        }
    }
    
}
