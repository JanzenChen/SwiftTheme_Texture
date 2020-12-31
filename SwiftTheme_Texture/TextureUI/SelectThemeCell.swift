//
//  SelectThemeCell.swift
//  SwiftTheme_Texture
//
//  Created by Janzen on 2020/12/30.
//  Copyright © 2020 com.beihai365. All rights reserved.
//

import AsyncDisplayKit
import SwiftTheme

class SelectThemeCell: BaseCell {
    
    lazy var titleNode = ASTextNode()
    lazy var themeIconNode = ASImageNode()
    lazy var detailNode = ASTextNode()
    override init() {
        super.init()
        
        titleNode.attributedText = NSAttributedString(string: "Select Theme")
        themeIconNode.contentMode = .scaleToFill
        addSubnode(titleNode)
        addSubnode(themeIconNode)
        addSubnode(detailNode)
        
        let attributedTextColors = ["#000", "#000", "#000", "#ECF0F1"]
        let titleAttributes = attributedTextColors.map { hexString in
            return [
                NSAttributedString.Key.foregroundColor: UIColor(rgba: hexString),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
            ]
        }
        
        titleNode.theme_textAttributes = ThemeStringAttributesPicker.pickerWithAttributes(titleAttributes)
        themeIconNode.theme_image = ["icon_theme_red", "icon_theme_yellow", "icon_theme_blue", "icon_theme_light"]
        
        let firstAttributes = [UIColor.red, UIColor.blue, UIColor.green, UIColor.white]
        let midAttributes = [UIColor.blue, UIColor.brown, UIColor.purple, UIColor.orange]
        let lastAttributes = [UIColor.magenta, UIColor.green, UIColor.blue, UIColor.darkGray]
        
        let firstAttributeTexts = firstAttributes.map { (color) -> NSMutableAttributedString in
            let attribute = [NSAttributedString.Key.foregroundColor: color,
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            return NSMutableAttributedString(string: "tap to ", attributes: attribute)
        }
        
        let midAttributeTexts = midAttributes.map { (color) -> NSAttributedString in
            let attribute = [NSAttributedString.Key.foregroundColor: color,
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            return NSAttributedString(string: "select ", attributes: attribute)
        }
        
        let lastAttributeTexts = lastAttributes.map { (color) -> NSAttributedString in
            let attribute = [NSAttributedString.Key.foregroundColor: color,
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            return NSAttributedString(string: "theme", attributes: attribute)
        }
        
        var attributeTexts: [NSMutableAttributedString] = []
        for i in 0..<firstAttributeTexts.count {
            let text = firstAttributeTexts[i]
            if i < midAttributeTexts.count {
                text.append(midAttributeTexts[i])
            }
            if i < lastAttributeTexts.count {
                text.append(lastAttributeTexts[i])
            }
            
            attributeTexts.append(text)
        }
        
        detailNode.theme_attributesTexts = ThemeAttributedStringPicker.pickerWithAttributedStrings(attributeTexts)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        titleNode.style.flexShrink = 1
        detailNode.style.flexShrink = 1
        themeIconNode.style.preferredSize = CGSize(width: 32, height: 32)
        let stackSpecV = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .center, alignItems: .start, children: [titleNode, detailNode])
        let stackSpecH = ASStackLayoutSpec(direction: .horizontal, spacing: 30, justifyContent: .start, alignItems: .center, children: [themeIconNode, stackSpecV])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15), child: stackSpecH)
    }
}
