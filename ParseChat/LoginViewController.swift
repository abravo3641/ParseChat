//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Anthony Bravo on 10/26/18.
//  Copyright © 2018 Anthony Bravo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.placeholder = "Username"
        passwordField.placeholder = "Password"
        singUpButton.layer.cornerRadius = 5
        singUpButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpClick(_ sender: Any) {
        //Checking if fields are empty, if true print alert
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty {
            printAlertMessage(title: "Error", message: "Username and email required")
        }
        else {
            //Creating New user from the PFuser table
            let newUser = PFUser()
            newUser.username = usernameField.text
            newUser.password = passwordField.text
            newUser.signUpInBackground { (success : Bool, error :Error?) in
                if success {
                    print("Created account!")
                    self.performSegue(withIdentifier: "loguinSegue", sender: nil)
                }
                else {
                    self.printAlertMessage(title: "Error", message: error!.localizedDescription )
                }
            }
        }
    }
 
    @IBAction func loginClick(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            //Check for errors loggin in
            if let error = error {
                self.printAlertMessage(title: "User log in failed", message: error.localizedDescription)
            } else {
                //User logged in successful, go to new view controller
                self.performSegue(withIdentifier: "loguinSegue", sender: nil)
            }
        }
    }
    
    
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    func printAlertMessage(title:String, message:String) {
        //creating alert
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //Making okay action button
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction) //adding the okay action
        present(alertController, animated: true)
    }
    
}
