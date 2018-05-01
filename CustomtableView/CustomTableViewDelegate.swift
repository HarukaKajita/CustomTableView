//
//  CustomTableViewDelegate.swift
//  UITableViewPractice
//
//  Created by 梶田悠 on 2018/04/29.
//  Copyright © 2018年 Haruka Kajita. All rights reserved.
//


///summury
/*
UITableViewDelegateとUITableViewDataSourceのデリゲートメソッドと同じ規約のプロトコル。
これを介して上記のメソッドを定義する事で一般処理と特殊処理を定義できる。
 */
import UIKit

protocol CustomTableViewProtocol{
    
    func customTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func customNumberOfSections(in tableView: UITableView) -> Int
    func customTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func customTableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    func customTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    func customTableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
}
