//
//  LaunchViewController.swift
//  HMWK
//
//  Created by Vincent Lewis on 11/25/18.
//  Copyright © 2018 HMWK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class LaunchViewController: UIViewController {

    @IBOutlet weak var teacherLaunchButton: UIButton!
    @IBOutlet weak var studentLaunchButton: UIButton!
    @IBOutlet weak var creationView: CreationView!
    
//      This is my comment for testing purposes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creationView.imageLabel.text = "sup"
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        FirebaseData.data.db = Firestore.firestore()

        teacherLaunchButton.layer.cornerRadius = teacherLaunchButton.frame.size.width/5
        studentLaunchButton.layer.cornerRadius = studentLaunchButton.frame.size.width/5
        
        teacherLaunchButton.layer.borderWidth = 2
        teacherLaunchButton.layer.borderColor = UIColor.black.cgColor
        
        studentLaunchButton.layer.borderWidth = 2
        studentLaunchButton.layer.borderColor = UIColor.black.cgColor
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "hmwklogo1"))
        
    }
}
