//
//  SignUpViewController.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-05-30.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameWarningLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordWarningLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func createAccountButtonClicked(_ sender: Any) {
        //Check if username already exists
        
        if(!doesUserExist() && isPasswordStrong() && isPasswordConfirmed()){
            
            if(UserDBHelper.dbHelper.addUser(usernameTextField.text!, passwordTextField.text!))
            {
                print("User added in core data")
                rememberSwitch()
                NotesViewController.username = usernameTextField.text!
                LoginViewController.theUser = usernameTextField.text!
                let storyboard = UIStoryboard(name : "Main", bundle : nil)
                let nextScreen = storyboard.instantiateViewController(withIdentifier: "MainNavBar")
                present(nextScreen, animated: true, completion: nil)
            }
            else{
                print("Error in saving user in core data")
                usernameWarningLabel.text = "Error registering user"
                usernameWarningLabel.isHidden = false
            }
        }
        else{
            if(isPasswordConfirmed()){
                confirmPasswordWarningLabel.isHidden = true
            }
            else{
                confirmPasswordWarningLabel.isHidden = false
            }
        }
        
    }
    func doesUserExist() -> Bool{
        //does database contain the useername?
        if(UserDBHelper.dbHelper.doesUserExist_Register(usernameTextField.text!))
        {
            usernameWarningLabel.text = "Username already taken"
            usernameWarningLabel.isHidden = false
            return true
        }
        else
        {
            usernameWarningLabel.isHidden = true
            return false
        }
    }
    func isPasswordStrong() -> Bool{
        //least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        let str = passwordTextField.text
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        if(passwordCheck.evaluate(with: str)){
            passwordWarningLabel.isHidden = true
            return true
        }
        else{
            passwordWarningLabel.isHidden = false
            return false
        }
    }
    func isPasswordConfirmed() -> Bool{
        if(passwordTextField.text == confirmPasswordTextField.text){
            return true
        }
        else{
            return false
        }
    }
    
    //For Remember me Switch
    func rememberSwitch(){
        if(rememberMeSwitch.isOn)
        {
            let attribute : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : usernameTextField.text, kSecValueData as String : passwordTextField.text!.data(using: .utf8)]
            if SecItemAdd(attribute as CFDictionary, nil) == noErr{
                userDefault.set(usernameTextField.text, forKey: "usernameForFunZone")
                userDefault.set(true, forKey: "rememberMeSwitchStatusForFunZone" )
                print("Username Remembered")
                print("username and password saved in keychain successfully")
                print("Remember switch turned on")
            }
            else{
                print("got some error saving password")
            }
        }
        else
        {
            userDefault.set(false, forKey: "rememberMeSwitchStatusForFeedbackAppLogin" )
            print("RememberME switch turned off")
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        if(NowPlayingViewController.audioPlayer != nil){
//            NowPlayingViewController.audioPlayer?.stop()
//        }
//    }
    
}
