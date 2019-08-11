//
//  IamLoaderImage.swift
//  IamLoader
//
//  Created by Andy on 09/08/19.
//  Copyright © 2019 Andy Wijaya. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

public class IamLoaderImage: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    public init() {
        super.init(frame: .zero)
        layer.masksToBounds = true
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
