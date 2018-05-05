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
    
    //表示するrowの数をカウントする変数。ここが0ならemptyViewが表示されます。
    var totalRowNum = Int(0)
    
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
    }
    
    @objc func refreshTable(){
        //emptyViewを削除しないとどんどん重なっていく
        emptyView?.removeFromSuperview()
        self.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    @objc func reload() {
        //emptyViewを削除しないとどんどん重なっていく
        emptyView?.removeFromSuperview()
        //更新
        self.reloadData()
    }
}



extension CustomTableView{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowNum = customTableViewDelegate.customTableView(tableView, numberOfRowsInSection:section)
        //rowNumが0だったらemptyView を表示させる処理をここに挟む。
        //それを表示させる親ビューを引数で受け取る。
        //表示させたいビューは任意で受け取る。
        self.totalRowNum += rowNum //表示するrowの数がカウントされる
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
    
    //ここが最後に呼ばれるdelegateメソッドっぽいのでここでemptyView表示の処理をする
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //表示するrowが無い場合にemptyViewが表示される
        if section == self.numberOfSections-1{
            if self.totalRowNum == 0 {
            showEmptyView()
            }
            self.totalRowNum = 0 //リセット
        }
        
        return customTableViewDelegate.customTableView(tableView, titleForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return customTableViewDelegate.customTableView(tableView, heightForHeaderInSection: section)
    }
}
