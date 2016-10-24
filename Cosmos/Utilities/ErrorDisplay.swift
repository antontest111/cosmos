//
//  ErrorDisplay.swift
//  Cosmos
//
//  Created by Anton Selyanin on 24/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

protocol ErrorDisplay {
    func show(error: String)
}

extension ErrorDisplay where Self: UIViewController {
    func show(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "This is fine", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
