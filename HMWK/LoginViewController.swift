//
//  LoginViewController.swift
//  HMWK
//
//  Created by Vincent Lewis on 4/7/19.
//  Copyright © 2019 HMWK. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func login(_ sender: Any) {
        NotFirebaseAuth.login(withEmail: emailTextField.text!, password: passwordTextField.text!, completionHandler: {(success) in
            if success {
                print("successfully logged in")
                
            } else {
                print("error")
            }
        })
    }
    
    
    @IBAction func createAccount(_ sender: Any) {
        NotFirebaseAuth.signUp(withEmail: emailTextField.text!, password: passwordTextField.text!, name: "Vince", userType: "Teacher",
                completionHandler: {(success) in
                    if success {
                        print("successfully logged in")
                                    
                    } else {
                        print("error")
                    }
        })
        
//        Create name textField
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = loginButton.frame.size.width/20
        createAccountButton.layer.cornerRadius = createAccountButton.frame.size.width/20
        
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = UIColor.black.cgColor
        
        createAccountButton.layer.borderWidth = 0.5
        createAccountButton.layer.borderColor = UIColor.black.cgColor
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "hmwklogo1"))

        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
