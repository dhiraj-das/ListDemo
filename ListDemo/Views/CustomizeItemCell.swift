//
//  CustomizeItemCell.swift
//  ListDemo
//
//  Created by Dhiraj Das on 3/2/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation
import UIKit

protocol CustomizeItemCellDelegate: class {
    func toggleSection(header: CustomizeItemCell, section: Int)
}

class CustomizeItemCell: UITableViewHeaderFooterView {
    
    var item: VariantsViewModelItem? {
        didSet {
            guard let item = item else {
                return
            }
            titleLabel.text = item.groupTitle
            setCollapsed(collapsed: item.isCollapsed)
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    var section: Int = 0

    weak var delegate: CustomizeItemCellDelegate?

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }

    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }

    func setCollapsed(collapsed: Bool) {
        arrowLabel?.rotate(collapsed ? 0.0 : .pi)
    }
}


extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
}
