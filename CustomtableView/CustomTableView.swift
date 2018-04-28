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
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("!")
        let rowNum = customTableViewDelegate.customTableView(tableView, numberOfRowsInSection:section)
        //rowNumが0だったら「空です」View を表示させる処理をここに挟む。
        //それを表示させる親ビューを引数で受け取る。
        //表示させたいビューは任意で受け取る。
        return rowNum
        //return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("!")
        return customTableViewDelegate.customNumberOfSections(in: tableView)
        //return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("!")
        let cell = customTableViewDelegate.customTableView(tableView, cellForRowAt:indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("!")
        return customTableViewDelegate.customTableView(tableView, heightForRowAt: indexPath)
        //return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print("!")
        return customTableViewDelegate.customTableView(tableView, titleForHeaderInSection: section)
        //return "title"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        print("!")
        return customTableViewDelegate.customTableView(tableView, heightForHeaderInSection: section)
        //return CGFloat(44)
    }

}
