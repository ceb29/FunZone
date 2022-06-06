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
    }
    
    @IBAction func submitButton(_ sender: Any) {
        if usernameTextField.text != nil && passwordTextField.text != nil{ //check if text fields hold valid text
            if isUniqueUser() && isValidUsernamePassword(){ //make sure username is unique and make sure text does not have spaces or is blank
                saveUser()
            }
        }
    }
    
    func isUniqueUser() -> Bool{
        //make sure user is unique
        let data = DBHelperUsers.dbHelper.getOneUserData(username: usernameTextField.text!)
        if data.userFlag{ //if userFlag is true, user already exist
            resultLabel.text = "That username already exists."
            return false //invalid new username
        }
        else{
            return true //valid new username
        }
    }
    
    func isValidUsernamePassword() -> Bool{
        //make sure text does not have spaces or is blank
        if isValidText(text: usernameTextField.text!) && isValidText(text: passwordTextField.text!){
            return true
        }
        resultLabel.text = "The username and password cannot have spaces or be blank."
        return false
    }
    
    func isValidText(text : String) -> Bool{
        //checks if text contains spaces or is blank
        if text.contains(" ") || text == ""{
            return false
        }
        return true
    }
    
    func saveUser(){
        //save user using Core Data framework
        DBHelperUsers.dbHelper.addUserData(usernameValue: usernameTextField.text!, passwordValue: passwordTextField.text!)
        goToLogin()
    }
    
    func goToLogin(){
        //go back to login screen
        self.navigationController?.popViewController(animated: true)
        //let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        //let welcomeScreen = storyBoard.instantiateViewController(withIdentifier: "Login")
        //present(welcomeScreen, animated: true,  completion: nil)
        //self.navigationController?.pushViewController(welcomeScreen, animated: true)
    }

}
