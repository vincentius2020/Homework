//
//  FirebaseAuth.swift
//  HMWK
//
//  Created by Sanjay Shah on 2019-04-05.
//  Copyright © 2019 HMWK. All rights reserved.
//

import Foundation
import KeychainAccess
import FirebaseAuth
import Firebase

class FirebaseAuth {
    
    class func signUp(withEmail email:String, password:String, name:String, userType: String, completionHandler: @escaping (_ success: Bool) -> Void )  {
        
        print("Signing up with email: \(email), password: \(password), name: \(name)")

        Auth.auth().createUser(withEmail: email,
                               password: password)
        { (newUser, registerError) in
            if registerError == nil {
          
                Auth.auth().currentUser?.sendEmailVerification(completion: { (verifyError) in
                    if (verifyError != nil) {
                        print("Error sending verification email: \(String(describing: verifyError))")
                    }
                    else {
                        print("Email sent")
                    }
                })
                
                let setUsername = Auth.auth().currentUser?.createProfileChangeRequest()
                setUsername?.displayName = name
                
                setUsername?.commitChanges(completion:
                    { (profileError) in
                        if profileError == nil {
                            let addedUser = User(aUsername: name, userEmail: email, aProfileImage: UIImage(), aUserType: userType, aEnrolledCourses: [])
                            
                            FirebaseData.data.currentUser = addedUser
                            
                            WriteFirebaseData.writeCurrentUser(completion: {(success) in
                                if success {
                                    print("Sign up successful and user written to database")
                                    completionHandler(true)
                                } else {
                                    print("Sign up successful BUT user not written to database")
                                    completionHandler(false)
                                }
                            })
                           
                            FirebaseAuth.addToKeychain(email: email, password: password)
                        }
                        else {
                            print("Error setting profile name: \(String(describing: profileError))")
                        }
                })
            }
            else {
                print("Error registering with Firebase: \(String(describing: registerError))")
            }
        }
    }
    
    
    class func addToKeychain(email:String, password:String) {
        
        print("Adding to keychain...")
        let keychain = Keychain(service: "com.homework")
        
        DispatchQueue.global().async {
            do {
                print("checking if keychain has key already")
                let alreadyInKeychain = try keychain.get("_\(email)")
                print("alreadyInKeychain: \(String(describing: alreadyInKeychain))")
                if alreadyInKeychain == nil {
                    do {
                        try keychain
                            .accessibility(.whenUnlocked, authenticationPolicy: .userPresence)
                            .set(password, key: email)
                        try keychain.set("yes", key: "_\(email)")
                        
                        print("Item added to keychain")
                    } catch let error {
                        // Error handling if needed...
                        print("Keychain Error: \(error)")
                    }
                }
            } catch let error {
                print("Keychain item existence check error: \(error)")
            }
            
        }
    }
    
    class func login(withEmail email:String, password:String, completionHandler: @escaping (_ success: Bool) -> Void) {
        print("Logging in with email: \(email), password: \(password)")
        
        print("Logging in to Firebase...")
        Auth.auth().signIn(withEmail: email,
                           password: password)
        { (authUser, loginError) in
            
            
            if loginError == nil {
               ReadFirebaseData.readCurrentUserWithCourses(userId: email, completion: {(success) in
                if success {
                    print("Login Successful and read User")
                    addToKeychain(email: email, password: password)
                    
                    // BusyActivityView.hide()
                    completionHandler(true)
                } else {
                    print("Login Successful but didnt read User")
                    addToKeychain(email: email, password: password)
                    
                    // BusyActivityView.hide()
                    completionHandler(false)
                }
               })
            }
            else {
                print("login failed: \(loginError.debugDescription)")
                completionHandler(false)
                
               // BusyActivityView.hide()
            }
        }
    }
    
    
    //havent tested this method yet
    class func loginWithTouchID(vc: UIViewController, email:String, completionHandler: @escaping (_ success: Bool) -> Void ) {
        
        let keychain = Keychain(service: "com.homework")
        
        DispatchQueue.global().async {
            do {
                let password = try keychain
                    .authenticationPrompt("Authenticate to login to server")
                    .get(email)
                
                print("password: \(String(describing: password))")
                
                DispatchQueue.main.async {
                   // BusyActivityView.show(inpVc: vc)
                }
                FirebaseAuth.login(withEmail: email, password: password!, completionHandler: completionHandler)
            } catch let error {
                // Error handling if needed...
                print("Error logging in using TouchID: \(error)")
            }
        }
    }
    
}

