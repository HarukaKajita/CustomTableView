//
//  ViewController.swift
//  UITableViewPractice
//
//  Created by 梶田悠 on 2018/01/04.
//  Copyright © 2018年 Haruka Kajita. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CustomTableViewProtocol{

    @IBOutlet weak var myTableView: CustomTableView!
    
    let dogImages = ["Pug", "Chihuahua", "Miniature Dachshund", "Maltese", "Corgi"]
    let sectionTitles = ["Dog"]
    
    var rowNum:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if rowNum == -1 {
            rowNum = dogImages.count
        }
        myTableView.customTableViewDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController{
    func customTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("rownum == \(rowNum)")
        return rowNum
    }
    
    func customNumberOfSections(in tableView: UITableView) -> Int {
        var sectionNum = sectionTitles.count
        if rowNum == 0 {
            sectionNum = 0
        }
        print("sectionNum == \(sectionNum)")
        return sectionNum
    }
    
    func customTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        cell.textLabel?.text = ":\(sectionTitles[indexPath.section])"
        
        cell.detailTextLabel?.text = "This is a \(dogImages[indexPath.row])"
        cell.imageView?.image = UIImage(named: "\(dogImages[indexPath.row]).png")
       
        return cell
    }
    
    func customTableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func customTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func customTableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
}

