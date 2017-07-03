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
    @IBOutlet weak var zabylParol: UIButton!
    
    var str = ""
    
    @IBAction func tapLogin(_ sender: UIButton) {
        if loginText.text != "" || passwordText.text != "" {
            Auth.auth().signIn(withEmail: loginText.text!, password: passwordText.text!) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    switch error.localizedDescription {
                        case "The password is invalid or the user does not have a password.":
                            self.zabylParol.isHidden = false
                            print("Неверный пароль")
                        default: break
                    }
                } else {
                    let user = Auth.auth().currentUser
                    if let user = user {
                        if user.isEmailVerified {
                            print("вошло")
                            print(user.uid)
                            print(user.email)
                            print(user.displayName)
                            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            //let vc = storyboard.instantiateViewController(withIdentifier: "qwerty") as! StartViewController
                            //self.present(vc, animated: false, completion: nil)
                            self.performSegue(withIdentifier: "seg", sender: nil)
                        } else {
                            print("Вы не подтвердили почту")
                        }
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segue123" {
                let vc = segue.destination as! registerViewController
                vc.strr = loginText.text!
        }
    }
}

