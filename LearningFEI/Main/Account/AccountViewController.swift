//
//  AccountViewController.swift
//  LearningFEI
//
//  Created by 周飞 on 2017/2/10.
//  Copyright © 2017年 ZF. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet var btn: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnClick(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
