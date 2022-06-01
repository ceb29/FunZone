//
//  LoginViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rememberSwitch: UISwitch!
    @IBOutlet weak var resultLabel: UILabel!
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load username and password if remember me was selected last time
        let rememberFlag = userDefault.integer(forKey: "rememberFlag")
        let remUser = userDefault.string(forKey: "username")
        if rememberFlag == 1{
            let user = getKey(remUser!)
            username.text = user[0]
            password.text = user[1]
        }
    }

    @IBAction func submitClicked(_ sender: Any) {
        if username.text != nil && password.text != nil{
            checkUser()
        }
    }
    
    func checkUser(){
        let data = DBHelperUsers.dbHelper.getOneUserData(username: username.text!) //get user data for current username text
    
        if data.userFlag{ //check if user exists
            let correctPassword = data.userData.password!
            if(password.text! == correctPassword){ //check if userId and password are valid
                saveUser() //method for handling remember me
                print("Welcome user", username.text)
                goToMusic() //load next screen
            }
            else{
                resultLabel.text = "Invalid Password"
            }
        }
        else{
            resultLabel.text = "Invalid Username"
        }
    }
    
    func goToMusic(){
        //go to next screen after login is successful
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeScreen = storyBoard.instantiateViewController(withIdentifier: "Start")
        //present(welcomeScreen, animated: true,  completion: nil)
        self.navigationController?.pushViewController(welcomeScreen, animated: true)
    }
    
    func saveUser(){
        if rememberSwitch.isOn {
            userDefault.set(1, forKey: "rememberFlag")
            userDefault.set(username.text!, forKey: "username")
            saveKey()
        }
        else{
            userDefault.set(0, forKey: "rememberFlag")
            deleteKey()
        }
    }
}

extension LoginViewController{
    //methods for storing username and password
    func saveKey() {
        let attribute : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : username.text, kSecValueData as String : password.text!.data(using: .utf8)]
        
        if SecItemAdd(attribute as CFDictionary, nil) == noErr{
            print("data saved successfully")
        }
        else{
            print("error during save")
        }
    }
    
    func getKey(_ username : String) -> [String] {
        let req : [String : Any] = [kSecClass as String: kSecClassGenericPassword, kSecAttrAccount as String : username, kSecReturnAttributes as String : true, kSecReturnData as String : true]
        
        var res : CFTypeRef?
        if SecItemCopyMatching(req as CFDictionary, &res) == noErr{
            let data = res as? [String : Any]
            let id = data![kSecAttrAccount as String] as? String
            let userPassword = (data![kSecValueData as String] as? Data)!
            let pass = String(data: userPassword, encoding: .utf8)
            let user = [id!, pass!]
            return user
        }
        else{
            return ["error", "error"]
        }
    }
    
    func updateKey() {
        let req : [String : Any] = [kSecClass as String: kSecClassGenericPassword, kSecAttrAccount as String : username.text]
        let attribute : [String : Any] = [kSecValueData as String : password.text!.data(using: .utf8)]
        if SecItemUpdate(req as CFDictionary, attribute as CFDictionary) == noErr{
            print("password updated")
        }
        else{
            print("error during update")
        }
        
    }
    
    func deleteKey() {
        let req : [String : Any] = [kSecClass as String: kSecClassGenericPassword, kSecAttrAccount as String : username.text]
        if SecItemDelete(req as CFDictionary)  == noErr{
            print("user deleted")
        }
        else{
            print("error during delete")
        }
    }
}

