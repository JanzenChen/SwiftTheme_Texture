//
//  ChangeThemeCell.swift
//  SwiftTheme_Texture
//
//  Created by Janzen on 2020/12/30.
//  Copyright © 2020 com.beihai365. All rights reserved.
//

import AsyncDisplayKit
import SwiftTheme

class ChangeThemeCell: BaseCell {
    lazy var changeThemeNode = ASButtonNode()
    
    override init() {
        super.init()
        
        let attributedTextColors = ["#FFF", "#000", "#FFF", "#000"]
        let attributesTitles = attributedTextColors.map { hexString -> NSAttributedString in
            let titleAttribute = [NSAttributedString.Key.foregroundColor: UIColor(rgba: hexString),
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            return NSAttributedString(string: "Change theme", attributes: titleAttribute)
        }
        
        changeThemeNode.theme_setAttributedTitle(ThemeAttributedStringPicker.pickerWithAttributedStrings(attributesTitles), forState: .normal)
        changeThemeNode.theme_setAttributedTitle(ThemeAttributedStringPicker.pickerWithAttributedStrings(attributesTitles), forState: .highlighted)
        changeThemeNode.style.preferredSize = CGSize(width: 120, height: 120)
        changeThemeNode.cornerRadius = 60
        addSubnode(changeThemeNode)
        
        changeThemeNode.addTarget(self, action: #selector(tapChange(_:)), forControlEvents: .touchUpInside)
    }
    
    override func didLoad() {
        super.didLoad()
        
        changeThemeNode.view.theme_backgroundColor = ["#EB4F38", "#F4C600", "#56ABE4", "#ECF0F1"]
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0), child: ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: changeThemeNode))
    }
    
    @objc
    func tapChange(_ sender: UIButton) {
        MyThemes.switchToNext()
    }
}
