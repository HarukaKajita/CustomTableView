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
    let catImages = ["American Shorthair", "Munchkin", "Persian", "Russian Blue", "Mikeneko"]
    let sectionTitles = ["Dog", "Cat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.customTableViewDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController{
    func customTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum: Int
        if section == 0 {
            rowNum = dogImages.count
        } else {
            rowNum = catImages.count
        }
        
        return rowNum
    }
    
    func customNumberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func customTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        cell.textLabel?.text = ":\(sectionTitles[indexPath.section])"
        
        if indexPath.section == 0 {
            cell.detailTextLabel?.text = "This is a \(dogImages[indexPath.row])"
            cell.imageView?.image = UIImage(named: "\(dogImages[indexPath.row]).png")
        } else {
            cell.detailTextLabel?.text = "This is a \(catImages[indexPath.row])"
            cell.imageView?.image = UIImage(named: "\(catImages[indexPath.row]).png")
        }
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

