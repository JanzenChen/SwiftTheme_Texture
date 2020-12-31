//
//  SwitchNightCell.swift
//  SwiftTheme_Texture
//
//  Created by Janzen on 2020/12/30.
//  Copyright © 2020 com.beihai365. All rights reserved.
//

import AsyncDisplayKit
import SwiftTheme

class SwitchNightCell: BaseCell {
    
    lazy var titleNode = ASTextNode()
    lazy var themeIconNode = ASImageNode()
    lazy var nightSwitch = UISwitch()
    
    override init() {
        super.init()
        
        titleNode.attributedText = NSAttributedString(string: "Night")
        themeIconNode.contentMode = .scaleToFill
        addSubnode(titleNode)
        addSubnode(themeIconNode)
        
        let attributedTextColors = ["#000", "#000", "#000", "#ECF0F1"]
        let titleAttributes = attributedTextColors.map { hexString in
            return [
                NSAttributedString.Key.foregroundColor: UIColor(rgba: hexString),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
            ]
        }
        
        titleNode.theme_textAttributes = ThemeStringAttributesPicker.pickerWithAttributes(titleAttributes)
        themeIconNode.theme_image = ["icon_night_dark", "icon_night_dark", "icon_night_dark", "icon_night_light"]
    }
    
    override func didLoad() {
        super.didLoad()
        
        updateNightSwitch()
        
        let bounds = self.bounds
        nightSwitch.frame = CGRect(x: bounds.width - 51 - 15, y: (bounds.height - 31) * 0.5 , width: 73, height: 31)
        nightSwitch.addTarget(self, action: #selector(changeNight(_:)), for: .valueChanged)
        self.view.addSubview(nightSwitch)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateNightSwitch), name: NSNotification.Name(rawValue: ThemeUpdateNotification), object: nil)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        themeIconNode.style.preferredSize = CGSize(width: 32, height: 32)
        let stackSpecH = ASStackLayoutSpec(direction: .horizontal, spacing: 30, justifyContent: .start, alignItems: .center, children: [themeIconNode, titleNode])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15), child: stackSpecH)
    }
    
    @objc func changeNight(_ sender: UISwitch) {
        MyThemes.switchNight(isToNight: sender.isOn)
    }
    
    @objc private func updateNightSwitch() {
        nightSwitch.isOn = MyThemes.isNight()
    }
}
