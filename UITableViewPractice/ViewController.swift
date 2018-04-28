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
        
//        let frame = self.view.bounds
//        let myTableView = CustomTableView(frame: frame, style: .plain)
        
        myTableView.customTableViewDelegate = self
        print("viewdidload")
        
    }
    
    func customTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNumber: Int
        if section == 0 {
            rowNumber = dogImages.count
        } else {
            rowNumber = catImages.count
        }
        print("numberOfRowsInSection")
        rowNumber = 0
        
        
        return rowNumber
    }
    
    func customNumberOfSections(in tableView: UITableView) -> Int {
        print("numberOfSections")
       
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
        print("cellForRowAt(\(indexPath.row))")
        return cell
    }
    
    func customTableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("heightForRowAt(\(indexPath.row))")
        return CGFloat(60)
    }
    
    func customTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print("titleForHeaderInSection")
        
        return sectionTitles[section]
    }
    
    func customTableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        print("heightForHeaderInSection")
        return CGFloat(44)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

