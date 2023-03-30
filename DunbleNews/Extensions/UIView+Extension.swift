//
//  UIView+Extension.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 30.03.2023.
//

import Foundation
import UIKit

extension UIView {
    func allSubviews() -> [UIView] {
        var res = self.subviews
        for subview in self.subviews {
            let riz = subview.allSubviews()
            res.append(contentsOf: riz)
        }
        return res
    }
}
