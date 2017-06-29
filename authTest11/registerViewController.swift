//
//  registerViewController.swift
//  authTest11
//
//  Created by user on 29.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import FirebaseAuth

class registerViewController: UIViewController {

    @IBOutlet weak var nickname: UITextField!
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func tapRegister(_ sender: UIButton) {
        if mailText.text != "" || passwordText.text != "" {
            Auth.auth().createUser(withEmail: mailText.text!, password: passwordText.text!) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    Auth.auth().signIn(withEmail: self.mailText.text!, password: self.passwordText.text!) { (user, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print("вошло")
                            /*Auth.auth().currentUser?.sendEmailVerification { (error) in
                                if let error = error {
                                    print(error.localizedDescription)
                                }
                            }*/
                            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.displayName = self.nickname.text
                            changeRequest?.commitChanges { (error) in
                                // ...
                            }
                        }
                    }
                }
            }
        } else {
            print("Не введен mail или пароль")
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
