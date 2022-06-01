//
//  SignUpViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButton(_ sender: Any) {
        if username.text != nil && password.text != nil{
            DBHelperUsers.dbHelper.addUserData(usernameValue: username.text!, passwordValue: password.text!)
            goToLogin()
        }
    }
    
    func goToLogin(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeScreen = storyBoard.instantiateViewController(withIdentifier: "Login")
        //present(welcomeScreen, animated: true,  completion: nil)
        self.navigationController?.pushViewController(welcomeScreen, animated: true)
    }
}
