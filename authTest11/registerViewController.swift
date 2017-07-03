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
    @IBOutlet weak var mailZabyl: UITextField!
    
    var strr = ""
    
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
                            Auth.auth().currentUser?.sendEmailVerification { (error) in
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "vccc") as! ViewController
                                vc.str = self.mailText.text!
                                self.present(vc, animated: false, completion: nil)
                            }
                            /*let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.displayName = self.nickname.text
                            changeRequest?.commitChanges { (error) in
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "vccc") as! ViewController
                                vc.str = self.mailText.text!
                            self.present(vc, animated: false, completion: nil)
                            }*/
                        }
                    }
                }
            }
        } else {
            print("Не введен mail или пароль")
        }
    }
    
    @IBAction func sendParolTap(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: strr) { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "vccc") as! ViewController
                vc.str = self.mailText.text!
                self.present(vc, animated: false, completion: nil)
                print("Пароль отправлен на почту")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mailZabyl.text = strr
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segue1" {
            /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "qwerty") as! StartViewController
            self.present(vc, animated: false, completion: nil)*/
        }

        
    }
    

}
