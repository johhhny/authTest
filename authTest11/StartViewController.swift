//
//  StartViewController.swift
//  authTest11
//
//  Created by Евгений Дорофеев on 01.07.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import Locksmith
import FirebaseAuth

class StartViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var newParol: UITextField!
    @IBOutlet weak var newParolRepeat: UITextField!
    
    var welcomeStr = ""
    var nameStr = ""
    var mailStr = ""
    
    @IBAction func deleteKey(_ sender: UIButton) {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: "AccountMyApp")
            print("Delete в Keychain")
        } catch {
            
        }
    }
    
    @IBAction func saveTap(_ sender: UIButton) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = self.nameTF.text
        changeRequest?.commitChanges { (error) in
            print("Сэйв инфы")
        }
        if mailTF.text != Auth.auth().currentUser?.email {
            Auth.auth().currentUser?.updateEmail(to: mailTF.text!) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("оьновлена почта")
                    Auth.auth().currentUser?.sendEmailVerification { (error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            if Auth.auth().currentUser != nil {
                                do {
                                    try Auth.auth().signOut()
                                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vccc")
                                    self.present(vc, animated: true, completion: nil)
                                    
                                } catch let error as NSError {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func saveParolTap(_ sender: UIButton) {
        if (newParol.text != "" && newParolRepeat.text != "") && (newParol.text == newParolRepeat.text) {
            Auth.auth().currentUser?.updatePassword(to: newParol.text!) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if Auth.auth().currentUser != nil {
                        do {
                            try Auth.auth().signOut()
                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vccc")
                            self.present(vc, animated: true, completion: nil)
                            
                        } catch let error as NSError {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*welcomeLabel.text = welcomeStr
        nameTF.text = nameStr
        mailTF.text = mailStr*/
        // Do any additional setup after loading the view.
        if let user = Auth.auth().currentUser {
            if let name = user.displayName {
                welcomeLabel.text = "Добро пожаловать, " + name
                nameTF.text = name
            } else {
                welcomeLabel.text = "Добро пожаловать, аноним"
                //vc.nameStr = "Аноним"
            }
            mailTF.text = user.email!
        }
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
