//
//  TeacherPromptsViewController.swift
//  HMWK
//
//  Created by Vincent Lewis on 9/7/18.
//  Copyright © 2018 HMWK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class TeacherPromptsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var teacherPromptCollectionView: UICollectionView!
    @IBOutlet weak var createPromptView: CreatePromptView!
    
//    let courseOptions = ["Science", "Math", "English"]
    
    var selectedPrompt: Prompt?
    var storageRef: StorageReference!
    var prompts: [Prompt] = []
    
    
    let courseOptions = ["Econ", "AP Micro", "AP HUG"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return courseOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return courseOptions[row]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createPromptView.coursePicker.delegate = self
        createPromptView.coursePicker.dataSource = self
        
        teacherPromptCollectionView.dataSource = self
        teacherPromptCollectionView.delegate = self

        createPromptView.courseNameLabel.text = "Select a Course"
        createPromptView.coursePicker.delegate = self
        createPromptView.promptTitleLabel.text = "Prompt Title"
        createPromptView.promptImageLabel.text = "Prompt Image"
        createPromptView.promptSummaryLabel.text = "Prompt Summary"
        createPromptView.promptTitleTextField.delegate = self
        createPromptView.promptSummaryTextField.delegate = self
        createPromptView.promptImageView.image = UIImage(named: "flower")
        
        createPromptView.createPromptButton.layer.cornerRadius = createPromptView.createPromptButton.frame.size.width/20
        createPromptView.createPromptButton.layer.borderWidth = 0.5
        createPromptView.createPromptButton.layer.borderColor = UIColor.black.cgColor
        
        createPromptView.imagePickerButton.setTitle("Choose new image", for: .normal)
        createPromptView.imagePickerButton.addTarget(self, action: #selector(imagePickerButtonPressed), for: .touchUpInside)
        
        for course in FirebaseData.data.enrolledCourses! {
            prompts.append(contentsOf: course.coursePrompts)
        }
        
        
        // Do any additional setup after loading the view.
        
        let layout = self.teacherPromptCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.teacherPromptCollectionView.frame.size.width)/2, height: (self.teacherPromptCollectionView.frame.size.height/3))
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "hmwklogo1"))
        
    }
    
    
    
    @objc func imagePickerButtonPressed(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        
        pickerController.delegate = self
        
        if TARGET_OS_SIMULATOR == 1 {
            pickerController.sourceType = .photoLibrary
        } else {
            pickerController.sourceType = .camera
            pickerController.cameraDevice = .front
            pickerController.cameraCaptureMode = .photo
        }
        
        self.present(pickerController, animated:true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // get image from info dictionary
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            //imageView has an image property set to be the image the user chose
            createPromptView.promptImageView.image = image
            
        }
        
        //dismiss the image picker
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FirebaseData.data.promptsInEnrolledCourses!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teacherPromptCell", for: indexPath) as! TeacherPromptCellCollectionViewCell
                
        let promptCell = FirebaseData.data.promptsInEnrolledCourses?[indexPath.row]
        
        storageRef = Storage.storage().reference()
        let imageReference = storageRef.child(promptCell!.promptImagePath)
        let placeholderImage = UIImage(named: "flower.jpg")
        cell.teacherPromptCellImageView.sd_setImage(with: imageReference, placeholderImage: placeholderImage)
        
        cell.teacherPromptCellLabel?.text = promptCell?.promptTitle
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        selectedPrompt = Singleton.singletonObject.allPrompts?[indexPath.row]
        selectedPrompt = FirebaseData.data.promptsInEnrolledCourses?[indexPath.row]
        
        self.performSegue(withIdentifier: "teacherPromptToResponses", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "teacherPromptToResponses") {
            if let newVC = segue.destination as? TeacherPromptResponsesViewController {
                newVC.currentPrompt = selectedPrompt
            }
        }
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

