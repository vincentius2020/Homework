//
//  TeacherHomeViewController.swift
//  HMWK
//
//  Created by Vincent Lewis on 8/26/18.
//  Copyright © 2018 HMWK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class TeacherHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var teacherHomeImageView: UIImageView!
    @IBOutlet weak var teacherHomeTableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var teacherHomeUsername: UILabel!
    
    var currentUser: User!
    var storageRef: StorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = FirebaseData.data.currentUser
        
        teacherHomeTableView.delegate = self
        teacherHomeTableView.dataSource = self
        
        teacherHomeUsername.text = FirebaseData.data.currentUser?.username
        
        storageRef = Storage.storage().reference()
        let imageReference = storageRef.child(currentUser.profileImagePath)
        let placeholderImage = UIImage(named: "flower.jpg")
        teacherHomeImageView.sd_setImage(with: imageReference, placeholderImage: placeholderImage)
        
//        teacherHomeImageView.image = FirebaseData.data.currentUser?.profileImage
        
        editButton.setTitle("Edit",for: .normal)
        
        //        navigationItem.titleView = UIImageView(image: UIImage(named: "hmwklogo1"))
        
        teacherHomeImageView.layer.cornerRadius = teacherHomeImageView.frame.size.width/2
        
        teacherHomeImageView.layer.borderWidth = 4
        teacherHomeImageView.layer.borderColor = UIColor.black.cgColor
        
    }
    
    
    @IBAction func editButtonPressed(_ sender: Any) {
        
        //create the controller
        let pickerController = UIImagePickerController()
        
        // message from pickerController to viewController
        pickerController.delegate = self
        
        if TARGET_OS_SIMULATOR == 1 {
            // check for simulator
            pickerController.sourceType = .photoLibrary
        } else {
            // check for iPhone or iPad and open camera
            // will they automatically be allowed to flip the camera?
            pickerController.sourceType = .camera
            pickerController.cameraDevice = .front
            pickerController.cameraCaptureMode = .photo
        }
        
        // present the pickerController
        self.present(pickerController, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // get image from info dictionary
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            //imageView has an image property set to be the image the user chose
            teacherHomeImageView.image = image
            
        }
        
        //dismiss the image picker
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//      return Singleton.singletonObject.allResponses!.count
        return FirebaseData.data.responsesInEnrolledCourses!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teacherFeedCell", for: indexPath) as! TeacherHomeTableViewCell
        
//      let response = Singleton.singletonObject.allResponses?[indexPath.row]
        let response = FirebaseData.data.responsesInEnrolledCourses?[indexPath.row]
        
//      let prompt = Singleton.singletonObject.allPrompts?.first(where: { $0.promptID == response?.promptID })
        let prompt = FirebaseData.data.promptsInEnrolledCourses?.first(where: { $0.promptID == response?.promptID })
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        
        cell.responseCellComment?.text = response?.comment
        cell.responseCellUsername?.text = response?.user.username
        
        storageRef = Storage.storage().reference()
        let imageReference = storageRef.child(response!.responseImagePath)
        let placeholderImage = UIImage(named: "flower.jpg")
        cell.teacherFeedImageView.sd_setImage(with: imageReference, placeholderImage: placeholderImage)
        
//        cell.teacherFeedImageView?.image = response?.image
        
        cell.responseCellPromptTitle?.text = prompt?.promptTitle
        
        return cell
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




