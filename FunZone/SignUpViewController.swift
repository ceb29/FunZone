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
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButton(_ sender: Any) {
        if username.text != nil && password.text != nil{
            if isUniqueUser() && isValidUsernamePassword(){
                saveUser()
            }
        }
    }
    
    func isUniqueUser() -> Bool{
        let data = DBHelperUsers.dbHelper.getOneUserData(username: username.text!)
        if data.userFlag{
            resultLabel.text = "That username already exists."
            return false
        }
        else{
            return true
        }
    }
    
    func isValidUsernamePassword() -> Bool{
        if isValidText(text: username.text!) && isValidText(text: password.text!){
            return true
        }
        resultLabel.text = "The username and password cannot have spaces or be blank."
        return false
    }
    
    func isValidText(text : String) -> Bool{
        if text.contains(" ") || text == ""{
            return false
        }
        return true
    }
    
    func saveUser(){
        DBHelperUsers.dbHelper.addUserData(usernameValue: username.text!, passwordValue: password.text!)
        goToLogin()
    }
    
    func goToLogin(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeScreen = storyBoard.instantiateViewController(withIdentifier: "Login")
        //present(welcomeScreen, animated: true,  completion: nil)
        self.navigationController?.pushViewController(welcomeScreen, animated: true)
    }
}
