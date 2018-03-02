//
//  VariationCell.swift
//  ListDemo
//
//  Created by Dhiraj Das on 3/2/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import UIKit

protocol VariationCellDelegate: class {
    func selected(itemId: String, sectionIndex: Int)
}

class VariationCell: UITableViewCell {

    @IBOutlet weak var foodTypeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var outOfStockImageView: UIImageView!
    
    var item: Variation? {
        didSet {
            guard let item = item else {
                return
            }
            
            outOfStockImageView.isHidden = item.inStock
            checkboxImageView.isHidden = !item.isSelected
            foodTypeImageView.image = item.isVeg ? #imageLiteral(resourceName: "veg") : #imageLiteral(resourceName: "nonveg")
            titleLabel.text = item.name
            priceLabel.text = "Rs. \(item.price)"
        }
    }
    
    weak var delegate: VariationCellDelegate?
    var sectionIndex: Int = 0
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCell)))
    }
    
    @objc private func didTapCell() {
        guard let _item = item else { return }
        guard _item.inStock else { return }
        delegate?.selected(itemId: _item.id, sectionIndex: sectionIndex)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        priceLabel.text = nil
        foodTypeImageView.image = nil
        checkboxImageView.isHidden = true
        outOfStockImageView.isHidden = true
    }
}
