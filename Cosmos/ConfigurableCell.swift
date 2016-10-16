//
//  ConfigurableCell.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class {
    static var reusableType: ReusableView.Type { get }
    
    static var reuseIdentifier: String { get }
    
    static var preferredHeight: CGFloat { get }
}

extension ReusableView {
    static var reusableType: ReusableView.Type {
        return self
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var preferredHeight: CGFloat {
        return 0
    }
}

protocol ConfigurableCell: ReusableView {
    associatedtype Item
    
    func configure(item: Item)
}

