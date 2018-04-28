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
    var inEmpty: Bool = false
    
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
        print("3 セクション内の行の数")
        let rowNum = customTableViewDelegate.customTableView(tableView, numberOfRowsInSection:section)
        //rowNumが0だったら「空です」View を表示させる処理をここに挟む。
        //それを表示させる親ビューを引数で受け取る。
        //表示させたいビューは任意で受け取る。
        if rowNum == 0 {
            self.inEmpty = true
        }
        return rowNum
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("1 セクションの数")
        return customTableViewDelegate.customNumberOfSections(in: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("4 セルの設定")
        let cell = customTableViewDelegate.customTableView(tableView, cellForRowAt:indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("5 行の高さ")
        
        return customTableViewDelegate.customTableView(tableView, heightForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print("5 セクションヘッダーのタイトル文字列")
        if self.inEmpty{
            showEmptyView(sectionIndex:0)
        }
        return customTableViewDelegate.customTableView(tableView, titleForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        print("2 セクションヘッダーの高さ")
      
        return customTableViewDelegate.customTableView(tableView, heightForHeaderInSection: section)
    }

    func showEmptyView(sectionIndex: Int) {
        let emptyView = UIView()
        let sectionHeaderFrame = rectForHeader(inSection: sectionIndex)
        print(rect(forSection: sectionIndex))
        print(rectForHeader(inSection: sectionIndex))
        let frame = CGRect(x: self.frame.minX, y: sectionHeaderFrame.maxY, width: self.frame.width, height: self.frame.height-sectionHeaderFrame.height)
        emptyView.frame = frame
        emptyView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.4)
        
        
        let infoLabel = UILabel(frame: CGRect(x: 0, y: 100, width: self.frame.width, height: 100))
        infoLabel.text = "取得できる情報がありませんでした。"
        infoLabel.textAlignment = .center
        infoLabel.textColor = UIColor.white
        emptyView.addSubview(infoLabel)
        self.addSubview(emptyView)
        //self.isScrollEnabled = false
    }
}
