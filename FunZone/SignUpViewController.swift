//
//  SignUpViewController.swift
//  FunZone
//
//  Created by admin on 6/4/22.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButton(_ sender: Any) {
        if usernameTextField.text != nil && passwordTextField.text != nil{
            if isUniqueUser() && isValidUsernamePassword(){
                saveUser()
            }
        }
    }
    
    func isUniqueUser() -> Bool{
        let data = DBHelperUsers.dbHelper.getOneUserData(username: usernameTextField.text!)
        if data.userFlag{
            resultLabel.text = "That username already exists."
            return false
        }
        else{
            return true
        }
    }
    
    func isValidUsernamePassword() -> Bool{
        if isValidText(text: usernameTextField.text!) && isValidText(text: passwordTextField.text!){
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
        DBHelperUsers.dbHelper.addUserData(usernameValue: usernameTextField.text!, passwordValue: passwordTextField.text!)
        goToLogin()
    }
    
    func goToLogin(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeScreen = storyBoard.instantiateViewController(withIdentifier: "Login")
        //present(welcomeScreen, animated: true,  completion: nil)
        self.navigationController?.pushViewController(welcomeScreen, animated: true)
    }

}
