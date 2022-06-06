//
//  LoginViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    var rememberIsOn = true
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRemember()
    }
    
    func setupRemember(){
        //load username and password if remember me was selected last time
        let rememberFlag = userDefault.integer(forKey: "rememberFlag")
        let remUser = userDefault.string(forKey: "username")
        if rememberFlag == 1{
            if remUser == nil{
                print("failed to save username")
            }
            else{
                let user = getKey(remUser!)
                usernameTextField.text = user.userData[0]
                passwordTextField.text = user.userData[1]
            }
        }
    }
    
    func checkUser(){
        //check if user exist and if not display invalid username
        //then check if password matches and if not display invalid password
        //if both username and password are valid, go to tab bar
        let data = DBHelperUsers.dbHelper.getOneUserData(username: usernameTextField.text!) //get user data for current username text
        if data.userFlag{ //check if user exists
            let correctPassword = data.userData.password!
            if(passwordTextField.text! == correctPassword){ //check if userId and password are valid
                saveUser() //method for handling remember me
                print("Welcome user", usernameTextField.text!)
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
        let startScreen = storyBoard.instantiateViewController(withIdentifier: "Start")
        //present(welcomeScreen, animated: true,  completion: nil)
        self.navigationController?.pushViewController(startScreen, animated: true)
    }
    
    func saveUser(){
        //if remember me is on set rememberFlag to on for next time using Userdefaults
        //then save the username and password using keychain
        if rememberIsOn {
            userDefault.set(1, forKey: "rememberFlag")
            userDefault.set(usernameTextField.text!, forKey: "username")
            saveOrUpdateKey()
        }
        else{
            userDefault.set(0, forKey: "rememberFlag")
            deleteKey()
        }
    }
    
    func saveOrUpdateKey(){
        //if app was deleted and key already exist update it else save
        let user = getKey(usernameTextField.text!)
        if user.keyFlag{
            updateKey()
        }
        else{
            saveKey()
        }
    }
    
    //
    //methods for storing username and password with keychain
    //
    func saveKey() {
        let attribute : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : usernameTextField.text, kSecValueData as String : passwordTextField.text!.data(using: .utf8)]
        if SecItemAdd(attribute as CFDictionary, nil) == noErr{
            print("data saved successfully")
        }
        //else{
            //print("error during save")
        //}
    }
    
    func getKey(_ username : String) -> (userData : [String], keyFlag: Bool) {
        let req : [String : Any] = [kSecClass as String: kSecClassGenericPassword, kSecAttrAccount as String : username, kSecReturnAttributes as String : true, kSecReturnData as String : true]
        
        var res : CFTypeRef?
        if SecItemCopyMatching(req as CFDictionary, &res) == noErr{
            let data = res as? [String : Any]
            let id = data![kSecAttrAccount as String] as? String
            let userPassword = (data![kSecValueData as String] as? Data)!
            let pass = String(data: userPassword, encoding: .utf8)
            let user = [id!, pass!]
            return (user, true)
        }
        else{
            return (["error", "error"], false)
        }
    }
    
    func updateKey() {
        let req : [String : Any] = [kSecClass as String: kSecClassGenericPassword, kSecAttrAccount as String : usernameTextField.text]
        let attribute : [String : Any] = [kSecValueData as String : passwordTextField.text!.data(using: .utf8)]
        if SecItemUpdate(req as CFDictionary, attribute as CFDictionary) == noErr{
            print("data saved succesfully1")
        }
        else{
            print("error during update")
        }
        
    }
    
    func deleteKey() {
        let req : [String : Any] = [kSecClass as String: kSecClassGenericPassword, kSecAttrAccount as String : usernameTextField.text]
        if SecItemDelete(req as CFDictionary)  == noErr{
            print("user deleted")
        }
        else{
            print("error during delete")
        }
    }
    
    //
    // end of keychain methods
    //
    
    @IBAction func changeRememberValue(_ sender: Any) {
        rememberIsOn = rememberIsOn ? false : true
        print(rememberIsOn)
        /*switch rememberIsOn{
        case true:
            rememberIsOn = false
        case false:
            rememberIsOn = true
        default:
            print("error when remember me changed")
        }*/
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        if usernameTextField.text != nil && passwordTextField.text != nil{
            checkUser()
        }
    }
}

