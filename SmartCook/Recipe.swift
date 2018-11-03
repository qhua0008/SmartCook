//
//  Recipe.swift
//  SmartCook
//
//  Created by Aditi on 03/11/18.
//  Copyright © 2018 Aditi. All rights reserved.
//

import UIKit

class Recipe: NSObject {
    var label: String?
    var url: String?
    var image: String?
    
    init(label: String, url: String, image: String) {
        self.label = label
        self.url = url
        self.image = image
    }
}
