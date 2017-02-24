//
//  CreateAccountViewController.swift
//  ZFHealth
//
//  Created by 周飞 on 2017/1/12.
//  Copyright © 2017年 ZF. All rights reserved.
//

import UIKit
import IBAnimatable
class CreateAccountViewController: UIViewController {
    @IBOutlet weak var HeaderView: AnimatableView!

    @IBOutlet weak var UserName: AnimatableTextField!
    
    @IBOutlet weak var UserEmail: AnimatableTextField!
    
    @IBOutlet weak var UserPassword: AnimatableTextField!
    
    @IBOutlet weak var UserGender: AnimatableTextField!
    
    @IBOutlet weak var UserBirthday: AnimatableTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserName.text = "zhoufei"
        UserName.tag = 2000
        UserEmail.text = "415770319@qq.com"
        UserEmail.tag = 2001
        UserPassword.text = "zhou9468334"
        UserPassword.tag = 2002
        UserBirthday.text = "19860728"
        UserBirthday.tag = 2003
        UserGender.text = "boy"
        UserGender.tag = 2004
        
        // Do any additional setup after loading the view.
    }

//    @IBAction func DoneCloseKeyboard(_ sender: Any) {
//        if let textField = sender as? UITextField{
//            textField.resignFirstResponder()
//        }
//
//    }

    @IBAction func Close(_ sender: AnimatableTextField) {
//        sender.resignFirstResponder()
        switch sender.tag {
        case 2000:
            UserEmail.becomeFirstResponder()
            
        case 2001:
            UserPassword.becomeFirstResponder()
            
        case 2002:
            UserBirthday.becomeFirstResponder()
            
        case 2003:
            UserGender.becomeFirstResponder()
            
        case 2004:
            self.registAccount()

        default:
            self.registAccount()
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Commit(_ sender: Any) {
        self.registAccount()
    }

    /// 注册账号
    func registAccount() {
        
        if !fixInfo(){
            return
        }
            
            
        let user = BmobUser()
        user.username = UserName.text
        user.password = UserPassword.text
//        user.setObject(UserEmail.text, forKey: "email")
        user.setObject(UserBirthday.text, forKey: "birthday")
        user.setObject(UserGender.text, forKey: "gender")

        user.signUpInBackground { (isSuccessful, error) in
            if isSuccessful {
                
                self.HeaderView.makeToast("注册成功")
                self.dismiss(animated: true, completion: nil)
                
                
//                self.performSegue(withIdentifier: "back", sender: self)
                
            }else{
                self.HeaderView.makeToast("注册失败\(error)")

            }
        }
    }
    

    func fixInfo() ->Bool {
        if (UserName.text?.isEmpty)! {
            self.HeaderView.makeToast("用户名为空")

            return false
        }
        else if (UserEmail.text?.isEmpty)! {
            self.HeaderView.makeToast("邮箱为空")

            return false
        }
        else if (UserPassword.text?.isEmpty)! {
            self.HeaderView.makeToast("密码为空")

            return false
        }
        else if (UserGender.text?.isEmpty)! {
            self.HeaderView.makeToast("性别为空")

            return false
        }
        else if (UserBirthday.text?.isEmpty)! {
            self.HeaderView.makeToast("生日为空")

            return false
        }
        else{
            return true
        }
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
