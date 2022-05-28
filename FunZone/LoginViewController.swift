//
//  LoginViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit
let userDefault = UserDefaults.standard
class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func submitClicked(_ sender: Any) {
        let userId = username.text!
        let pass = password.text!
        if(userId == "abc" && pass == "123"){
            print("Welcome user", userId)
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let welcomeScreen = storyBoard.instantiateViewController(withIdentifier: "Start")
            //present(welcomeScreen, animated: true,  completion: nil)
            self.navigationController?.pushViewController(welcomeScreen, animated: true)
        }
        else{
            print("Invalid userId")
        }
    }
}


