//
//  ViewController.swift
//  LearningFEI
//
//  Created by 周飞 on 2017/2/8.
//  Copyright © 2017年 ZF. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var preView: UIView!
    @IBOutlet weak var loginView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserDefaults.standard.bool(forKey: "firstLaunch") {
            UserDefaults.standard.set(true, forKey: "firstLaunch")
            preView.isHidden = false
            loginView.isHidden = true
        } else {
            preView.isHidden = true
            loginView.isHidden = false
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

