//
//  CustomTableViewDelegate.swift
//  UITableViewPractice
//
//  Created by 梶田悠 on 2018/04/29.
//  Copyright © 2018年 Haruka Kajita. All rights reserved.
//

//import Foundation
import UIKit

protocol CustomTableViewProtocol: UITableViewDelegate, UITableViewDataSource{
    
    //UITableViewDelegateのextensionで定義を書いちゃう
    //
    
    func customTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func customNumberOfSections(in tableView: UITableView) -> Int
    func customTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func customTableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    func customTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    func customTableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
}

extension CustomTableViewProtocol{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowNum = customTableView(tableView, numberOfRowsInSection:section)
        //rowNumが0だったら「空です」View を表示させる処理をここに挟む。
        //それを表示させる親ビューを引数で受け取る。
        //表示させたいビューは任意で受け取る。
        return rowNum
        //return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return customNumberOfSections(in: tableView)
        //return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = customTableView(tableView, cellForRowAt:indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return customTableView(tableView, heightForRowAt: indexPath)
        //return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return customTableView(tableView, titleForHeaderInSection: section)
        //return "title"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return customTableView(tableView, heightForHeaderInSection: section)
        //return CGFloat(44)
    }
}
