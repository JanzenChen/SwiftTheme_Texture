//
//  AboutCell.swift
//  SwiftTheme_Texture
//
//  Created by Janzen on 2020/12/30.
//  Copyright © 2020 com.beihai365. All rights reserved.
//

import AsyncDisplayKit
import SwiftTheme

class AboutCell: BaseCell {
    
    lazy var contentNode = ASTextNode()
    
    override init() {
        super.init()
        
        contentNode.attributedText = NSAttributedString(string: "SwiftTheme use in Texture")
        addSubnode(contentNode)
        
        
        let attributedTextColors = ["#000", "#000", "#000", "#ECF0F1"]
        let titleAttributes = attributedTextColors.map { hexString in
            return [
                NSAttributedString.Key.foregroundColor: UIColor(rgba: hexString),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
            ]
        }
        
        contentNode.theme_textAttributes = ThemeStringAttributesPicker.pickerWithAttributes(titleAttributes)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0), child: ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: contentNode))
    }
}
