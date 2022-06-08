//
//  LoginViewController.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-05-29.
//

import UIKit

class LoginViewController: UIViewController {
    
    static var theUser : String?
    @IBOutlet weak var usernameWarningLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkRememberMeSwitch()
    }
    
    //To check if a user is saved in userdefaults
    func checkRememberMeSwitch(){
        
        let rememberMeSwitchStatus = userDefault.bool(forKey: "rememberMeSwitchStatusForFunZone")
        print("Remember Switch initial status is", rememberMeSwitchStatus)
        if(rememberMeSwitchStatus){
            checkRememberedUser()
            rememberMeSwitch.setOn(true, animated: true)
        }
        else{
            rememberMeSwitch.setOn(false, animated: true)
        }
    }
    
    
    //Get the user and teh encrypted password from the keychain
    func checkRememberedUser()
    {
        let
        rememberedUsername = userDefault.string(forKey: "usernameForFunZone") ?? nil
        print("Remembered Username: ", rememberedUsername)
        if(rememberedUsername != nil)
        {
            let req : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : rememberedUsername, kSecReturnAttributes as String : true, kSecReturnData as String : true]
            var response : CFTypeRef?
            if SecItemCopyMatching(req as CFDictionary, &response) == noErr{
                let data = response as? [String : Any]
                let userId = data![kSecAttrAccount as String] as? String
                let encryptedPassword = (data![kSecValueData as String] as? Data)!
                let userPassword = String(data : encryptedPassword, encoding: .utf8)
                usernameTextField.text = userId
                passwordTextField.text = userPassword
                print("ID in keychain is: ",userId," Password in keychanin is: ",userPassword)
                print("Encrypted Password: ",encryptedPassword)
            }
            else{
                print("got some error viewing password from keychain")
            }
        }
        else
        {
            
        }
    }
    

    @IBAction func signInButtonClicked(_ sender: Any) {
        
        let uID = usernameTextField.text!
        let pass = passwordTextField.text!
        let isUserCorrect = UserDBHelper.dbHelper.doesUserExist_Login(uID)
        let isPassCorrect = UserDBHelper.dbHelper.isPasswordCorrect(uID, pass)
        if(isUserCorrect && isPassCorrect)
        {
            if(rememberMeSwitch.isOn)
            {
                rememberValidUser(uID: uID, uPass: pass)
                userDefault.set(true, forKey: "rememberMeSwitchStatusForFunZone")
                print("Remember Me switch turned on")
            }
            else{
                forgetVaildUser(uID: uID)
                userDefault.set(false, forKey: "rememberMeSwitchStatusForFunZone")
                print("Remember me switch turned off")
            }
            NotesViewController.username = uID
            LoginViewController.theUser = uID
            let storyboard = UIStoryboard(name : "Main", bundle : nil)
            let nextScreen = storyboard.instantiateViewController(withIdentifier: "MainNavBar")
            present(nextScreen, animated: true, completion: nil)
            
        }
        else{
            
            if(isUserCorrect)
            {
                usernameWarningLabel.isHidden = true
            }
            else
            {
                usernameWarningLabel.isHidden = false
            }
            
            if(isPassCorrect)
            {
                passwordWarningLabel.isHidden = true
            }
            else
            {
                passwordWarningLabel.isHidden = false
            }
        }
        
    }
    
    //save the user and password confirmed for siging in to the userdeafault and keychain if  the switch is turned on
    func rememberValidUser(uID : String, uPass : String){
        
        userDefault.set(uID, forKey: "usernameForFunZone")
        let attribute : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : uID, kSecValueData as String : uPass.data(using: .utf8)]
        if SecItemAdd(attribute as CFDictionary, nil) == noErr{
            print("username and password saved in keychain successfully")
        }
        else{
            print("got some error saving username and password in keychain")
        }
        
    }
    
    func forgetVaildUser(uID : String)
    {
        userDefault.set(nil, forKey: "usernameForFunZone")
        let req : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : uID]
        if(SecItemDelete(req as CFDictionary) == noErr){
            print("Username and Password Deleted from keychain")
        }
        else{
            print("got an error deleting username  and password")
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        if(NowPlayingViewController.audioPlayer != nil){
//            NowPlayingViewController.audioPlayer?.stop()
//        }
//    }
    

}
