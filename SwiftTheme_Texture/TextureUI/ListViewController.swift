//
//  ListViewController.swift
//  SwiftTheme_Texture
//
//  Created by Janzen on 2020/12/30.
//  Copyright © 2020 com.beihai365. All rights reserved.
//

import AsyncDisplayKit
import SwiftTheme

class ListViewController: ASDKViewController<ASDisplayNode> {
    
    lazy var tabNode = ASTableNode()
    
    override init() {
        super.init(node: ASDisplayNode())
        node.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTheme()
        
        title = "SwiftTheme_Texture"
        
        node.addSubnode(tabNode)
        tabNode.dataSource = self
        tabNode.delegate = self
        tabNode.frame = self.view.bounds
        tabNode.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabNode.view.separatorStyle = .singleLine
        tabNode.view.tableFooterView = UIView()
        // set themme theme_backgroundColor
        tabNode.view.theme_backgroundColor = GlobalPicker.backgroundColor
        tabNode.view.theme_separatorColor = ["#C6C5C5", "#C6C5C5", "#C6C5C5", "#ECF0F1"]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        MyThemes.switchToNext()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard
            #available(iOS 13.0, *),
            traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
            else { return }
        
        updateTheme()
    }
    
    private func updateTheme() {
        guard #available(iOS 12.0, *) else { return }
        
        switch traitCollection.userInterfaceStyle {
        case .light:
            MyThemes.switchNight(isToNight: false)
        case .dark:
            MyThemes.switchNight(isToNight: true)
        case .unspecified:
            break
        @unknown default:
            break
        }
    }
}

extension ListViewController: ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        return { [weak self] in
            guard let _ = self else {
                return ASCellNode()
            }
            
            switch indexPath.row {
            case 0:
                return AboutCell()
            case 1:
                return SelectThemeCell()
            case 2:
                return SwitchNightCell()
            case 3:
                return ChangeThemeCell()
            default:
                return ASCellNode()
            }
        }
    }
    
    
}

extension ListViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        if 1 == indexPath.row {
            let vc = SelectThemeViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
