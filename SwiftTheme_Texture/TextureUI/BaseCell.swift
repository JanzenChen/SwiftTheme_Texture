//
//  BaseCell.swift
//  SwiftTheme_Texture
//
//  Created by Janzen on 2020/12/30.
//  Copyright © 2020 com.beihai365. All rights reserved.
//

import AsyncDisplayKit
import UIKit

class BaseCell: ASCellNode {
    override func didLoad() {
        super.didLoad()
        
        view.theme_backgroundColor = GlobalPicker.backgroundColor
    }
}
