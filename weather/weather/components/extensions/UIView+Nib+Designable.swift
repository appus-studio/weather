//
//  UIView+Nib+Designable.swift
//  weather
//
//  Created by Alexey Kubas on 3/27/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    func fromNib<T: UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            // xib not loaded, or its top self is of the wrong type
            return nil
        }
        self.backgroundColor = .clear
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: contentView,
                                               attribute: NSLayoutConstraint.Attribute.top,
                                               relatedBy: NSLayoutConstraint.Relation.equal,
                                               toItem: self, attribute: NSLayoutConstraint.Attribute.top,
                                               multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: contentView,
                                                  attribute: NSLayoutConstraint.Attribute.bottom,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: self, attribute: NSLayoutConstraint.Attribute.bottom,
                                                  multiplier: 1,
                                                  constant: 0)
        let leftConstraint = NSLayoutConstraint(item: contentView,
                                                attribute: NSLayoutConstraint.Attribute.left,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: self, attribute: NSLayoutConstraint.Attribute.left,
                                                multiplier: 1,
                                                constant: 0)
        let rigtConstraint = NSLayoutConstraint(item: contentView,
                                                attribute: NSLayoutConstraint.Attribute.right,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: self,
                                                attribute: NSLayoutConstraint.Attribute.right,
                                                multiplier: 1,
                                                constant: 0)
        self.addConstraints([topConstraint, bottomConstraint, leftConstraint, rigtConstraint])
        return contentView
    }
}
