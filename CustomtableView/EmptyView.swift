//
//  EmptyView.swift
//  UITableViewPractice
//
//  Created by 梶田悠 on 2018/04/29.
//  Copyright © 2018年 Haruka Kajita. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.4)
        let infoLabel = UILabel(frame: CGRect(x: 0, y: 100, width: self.frame.width, height: 100))
        infoLabel.text = "取得できる情報がありませんでした。"
        infoLabel.textAlignment = .center
        infoLabel.textColor = UIColor.white
        self.addSubview(infoLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
