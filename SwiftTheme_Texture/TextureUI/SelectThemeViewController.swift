//
//  SelectThemeViewController.swift
//  SwiftTheme_Texture
//
//  Created by 陈家将 on 2020/12/31.
//  Copyright © 2020 com.beihai365. All rights reserved.
//

import AsyncDisplayKit
import SwiftTheme

class SelectThemeViewController: ASDKViewController<ASDisplayNode> {
    
    override init() {
        super.init(node: ASDisplayNode())
        node.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Select Theme"
        
        let content = SelectThemeContentView()
        let barH =  UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height ?? 0)
        content.frame = CGRect(x: 0, y: barH, width: self.view.bounds.width, height: self.view.bounds.height - barH)
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        node.addSubnode(content)
    }

}

class SelectThemeContentView: ASDisplayNode {
    var buttonNodes: [ASButtonNode] = []
    
    override init() {
        super.init()
        self.backgroundColor = .white
        buttonNodes = []
        
        let themes = ["red Theme", "Yellow Theme", "Blue Theme"]
        let themeColors: [UIColor] = [.red, .yellow, .blue]
        for (index, title) in themes.enumerated() {
            let buttonNode = ASButtonNode()
            buttonNode.setTitle(title, with: UIFont.systemFont(ofSize: 16), with: 1 == index ? .black : .white, for: .normal)
            buttonNode.view.tag = index
            buttonNode.addTarget(self, action: #selector(changeTheme(_:)), forControlEvents: .touchUpInside)
            buttonNode.backgroundColor = themeColors[index]
            buttonNode.style.flexGrow = 1
            buttonNode.cornerRadius = 10
            self.addSubnode(buttonNode)
            buttonNodes.append(buttonNode)
        }
    }
    
    @objc
    func changeTheme(_ sender: ASButtonNode) {
        switch sender.view.tag {
        case 0: fallthrough
        case 1: fallthrough
        case 2:
            MyThemes.switchTo(theme: MyThemes(rawValue: sender.view.tag)!)
        default:
            break
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackSpecV = ASStackLayoutSpec(direction: .vertical, spacing: 20, justifyContent: .center, alignItems: .stretch, children: buttonNodes)
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), child: stackSpecV)
    }
}
