//
//  LoginViewController.swift
//  Instagram
//
//  Created by Chase Warren on 6/27/17.
//  Copyright © 2017 Chase Warren. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User login failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "login", sender: nil)
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("Successfuly created new user")
                self.performSegue(withIdentifier: "login", sender: nil)
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
