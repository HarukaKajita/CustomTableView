//
//  EditViewController.swift
//  UITableViewPractice
//
//  Created by 梶田悠 on 2018/05/06.
//  Copyright © 2018年 Haruka Kajita. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var rowNumLabel: UILabel!
    //遷移元のViewController
    var vc: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let count = (self.navigationController?.viewControllers.count)! - 2
        vc = self.navigationController?.viewControllers[count] as! ViewController
        
        rowNumLabel.text = String(vc.rowNum)
    }

    @IBAction func tapPlus(_ sender: Any) {
        vc.rowNum += 1
        if vc.rowNum > 5 {
            vc.rowNum = 5
        }
        self.rowNumLabel.text = String(vc.rowNum)
    }
    
    @IBAction func tapMinus(_ sender: Any) {
        vc.rowNum -= 1
        if vc.rowNum < 0 {
            vc.rowNum = 0
        }
        self.rowNumLabel.text = String(vc.rowNum)
    }
}
