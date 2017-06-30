//
//  ViewController.swift
//  authTest11
//
//  Created by Евгений Дорофеев on 27.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var str = ""
    
    @IBAction func tapLogin(_ sender: UIButton) {
        if loginText.text != "" || passwordText.text != "" {
            Auth.auth().signIn(withEmail: loginText.text!, password: passwordText.text!) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("вошло")
                    let user = Auth.auth().currentUser
                    if let user = user {
                        // The user's ID, unique to the Firebase project.
                        // Do NOT use this value to authenticate with your backend server,
                        // if you have one. Use getTokenWithCompletion:completion: instead.
                        print(user.uid)
                        print(user.email)
                        print(user.displayName)
                        // ...
                    }
                }
            }
        } else {
            print("Не введен логин или пароль")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1231231231231")
        let user = Auth.auth().currentUser
        if let user = user {
            print(user.email)
            loginText.text = str
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

