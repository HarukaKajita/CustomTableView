//
//  CustomtableView.swift
//  UITableViewPractice
//
//  Created by 梶田悠 on 2018/04/29.
//  Copyright © 2018年 Haruka Kajita. All rights reserved.
//

import UIKit

class CustomTableView: UITableView, UITableViewDelegate, UITableViewDataSource{

    //このデリゲートメソッドの定義を書き手に書いてもらう
    //基本的なUITableViewDelegateのデリゲートメソッドは書かなくてOKにする
    var customTableViewDelegate: CustomTableViewProtocol!
   
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        self.delegate = self
        self.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowNum = customTableViewDelegate.customTableView(tableView, numberOfRowsInSection:section)
        //rowNumが0だったら「空です」View を表示させる処理をここに挟む。
        //それを表示させる親ビューを引数で受け取る。
        //表示させたいビューは任意で受け取る。
        if rowNum == 0 {
            let emptyView = UIView()
            let frame = self.frame
            emptyView.frame = frame
            emptyView.backgroundColor = UIColor.brown
            self.addSubview(emptyView)
        }
        return rowNum
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return customTableViewDelegate.customNumberOfSections(in: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = customTableViewDelegate.customTableView(tableView, cellForRowAt:indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return customTableViewDelegate.customTableView(tableView, heightForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return customTableViewDelegate.customTableView(tableView, titleForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return customTableViewDelegate.customTableView(tableView, heightForHeaderInSection: section)
    }

}
