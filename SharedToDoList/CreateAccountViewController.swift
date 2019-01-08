//
//  CreateAccountViewController.swift
//  SharedToDoList
//
//  Created by Nikhil Trivedi on 1/4/19.
//  Copyright © 2019 Nikhil Trivedi. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {

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
    
    @IBAction func Continue(_ sender: UIBarButtonItem) {
        Auth.auth().createUser(withEmail: Email.text!, password: Password.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                self.performSegue(withIdentifier: "GoToList", sender: self)
            }
        }
    }
    
}
