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
    private var emptyView: EmptyView?
    private var customEmptyView: UIView? //emptyViewを独自に変えたい場合はこれに代入
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setup()
    }
    //独自のemptyViewを使う時用のコンストラクタ
    init(frame: CGRect, style: UITableViewStyle, emptyView: UIView) {
        super.init(frame: frame, style: style)
        self.customEmptyView = emptyView
    }
    
    private func setup(){
        self.delegate = self
        self.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTable), for: UIControlEvents.valueChanged)
        self.refreshControl = refreshControl
    }
    
    func showEmptyView() {
        //emptyView表示領域 → TableViewにかぶさる
        let frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.height)
        //独自のemptyViewが用意されている場合はそれを使う
        if customEmptyView != nil {
            customEmptyView?.frame = frame
            emptyView = customEmptyView as? EmptyView
        } else {
            emptyView = EmptyView(frame: frame, useRefreshButton: true)
            emptyView?.reloadButton?.addTarget(self, action: #selector(reload), for: .touchUpInside)
        }
        self.addSubview(emptyView!)
    }
    
    @objc func refreshTable(){
        reload()
        self.refreshControl?.endRefreshing()
    }
    
    @objc func reload() {
        print("reload")
        //emptyViewを削除しないとどんどん重なっていく
        emptyView?.removeFromSuperview()
        emptyView = nil
        //更新
        self.reloadData()
    }
}



extension CustomTableView{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customTableViewDelegate.customTableView(tableView, numberOfRowsInSection:section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let sectionNum = customTableViewDelegate.customNumberOfSections(in: tableView)
        //セクション数が0の時にemptyViewが表示される
        if sectionNum == 0 && self.emptyView == nil{
            showEmptyView()
        }
        return sectionNum
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
