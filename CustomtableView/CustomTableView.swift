//
//  CustomtableView.swift
//  UITableViewPractice
//
//  Created by 梶田悠 on 2018/04/29.
//  Copyright © 2018年 Haruka Kajita. All rights reserved.
//

import UIKit
//複数セクションを使う場合は考慮していません。→emptyViewの表示の仕方をどうするかを定めれば改善の余地あり
class CustomTableView: UITableView, UITableViewDelegate, UITableViewDataSource{

    //このデリゲートメソッドの定義を書き手に書いてもらう
    //基本的なUITableViewDelegateのデリゲートメソッドは書かなくてOKにする
    var customTableViewDelegate: CustomTableViewProtocol!
    var isEmpty: Bool = false
    var emptyView: EmptyView?
    var reloadInterval = 0.5
    
    //更新を試す為に一時的にフィールドに定義
    var rowNum:Int = 0
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setup()
    }
    
    private func setup(){
        self.delegate = self
        self.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTable), for: UIControlEvents.valueChanged)
        self.refreshControl = refreshControl
    }
    
    func showEmptyView(sectionIndex: Int = 0) {
        let sectionHeaderFrame = rectForHeader(inSection: sectionIndex)
        
        let frame = CGRect(x: self.bounds.minX, y: sectionHeaderFrame.maxY, width: self.bounds.size.width, height: self.frame.height-sectionHeaderFrame.height)
        emptyView = EmptyView(frame: frame, useRefreshButton: true)
        emptyView?.reloadButton?.addTarget(self, action: #selector(reload), for: .touchUpInside)
        self.addSubview(emptyView!)
        //self.isScrollEnabled = false //←これは任意で
    }
    @objc func refreshTable(){
        //emptyViewを削除しないとどんどん重なっていく
        emptyView?.removeFromSuperview()
        self.rowNum = 3 //サンプルの為強制的にデータを取得できるようにしている
        self.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    @objc func reload() {
        //emptyViewを削除しないとどんどん重なっていく
        emptyView?.removeFromSuperview()
        //更新が早すぎて更新されたかどうかが分からないので0.5秒開けています。
        DispatchQueue.main.asyncAfter(deadline: .now() + reloadInterval) {
            self.rowNum = 3 //サンプルの為強制的にデータを取得できるようにしている
            self.reloadData()
        }
        
    }
}



extension CustomTableView{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("3 セクション内の行の数")
        //rowNum = customTableViewDelegate.customTableView(tableView, numberOfRowsInSection:section)
        //rowNumが0だったらemptyView を表示させる処理をここに挟む。
        //それを表示させる親ビューを引数で受け取る。
        //表示させたいビューは任意で受け取る。
        if rowNum == 0 {
            self.isEmpty = true
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
        //emptyViewはセクションの形が定まってからじゃないとならないのでここに書いてあります。
        if self.isEmpty{
            showEmptyView()
            self.isEmpty = false
        }
        return customTableViewDelegate.customTableView(tableView, titleForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        print("2 セクションヘッダーの高さ")
        
        return customTableViewDelegate.customTableView(tableView, heightForHeaderInSection: section)
    }
}
