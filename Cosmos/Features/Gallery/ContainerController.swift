//
//  ContainerController.swift
//  Cosmos
//
//  Created by Anton Selyanin on 18/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

class ContainerController: UIViewController {
    private let imageView: UIImageView
    
    init(image: UIImage?) {
        imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        view.addSubview(imageView)
        imageView.autoPinEdgesToSuperviewEdges()
    }
    
    func set(image: UIImage?) {
        imageView.image = image
    }
}
