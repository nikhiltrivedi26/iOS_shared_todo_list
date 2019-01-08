//
//  LogInViewController.swift
//  SharedToDoList
//
//  Created by Nikhil Trivedi on 1/4/19.
//  Copyright © 2019 Nikhil Trivedi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class LogInViewController: UIViewController {

    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Email.placeholder = "Email"
        Password.placeholder = "Password"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func ContinuePressed(_ sender: UIBarButtonItem) {
        Auth.auth().signIn(withEmail: Email.text!, password: Password.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                self.performSegue(withIdentifier: "GoToList", sender: self)
            }
        }
    }
    
    
    

}
