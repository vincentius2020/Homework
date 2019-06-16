//
//  StudentPromptResponsesViewController.swift
//  HMWK
//
//  Created by Vincent Lewis on 12/17/18.
//  Copyright © 2018 HMWK. All rights reserved.
//

import UIKit
import Firebase

class StudentPromptResponsesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var studentPromptResponsesCollectionView: UICollectionView!
    @IBOutlet weak var promptImageView: UIImageView!
    @IBOutlet weak var promptTitleLabel: UILabel!
    @IBOutlet weak var promptCommentLabel: UILabel!
    @IBOutlet weak var createResponseView: CreateResponseView!
    
    var currentPrompt: Prompt!
    var storageRef: StorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        studentPromptResponsesCollectionView.dataSource = self
        studentPromptResponsesCollectionView.delegate = self
        
        createResponseView.newResponseLabel.text = "New Response"
        createResponseView.imageLabel.text = "Image"
        
        createResponseView.responseImageView.image = UIImage(named: "flower")
        
        createResponseView.imagePickerButton.setTitle("Choose new image", for: .normal)
        createResponseView.imagePickerButton.addTarget(self, action: #selector(imagePickerButtonPressed), for: .touchUpInside)
        
        createResponseView.explanationLabel.text = "Explanation"
        
        createResponseView.explanationTextField.delegate = self
        
        createResponseView.submitButton.layer.cornerRadius = createResponseView.submitButton.frame.size.width/20
        createResponseView.submitButton.layer.borderWidth = 0.5
        createResponseView.submitButton.layer.borderColor = UIColor.black.cgColor
        
        let layout = self.studentPromptResponsesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.studentPromptResponsesCollectionView.frame.size.width)/2, height: (self.studentPromptResponsesCollectionView.frame.size.height/2.25))
        
        storageRef = Storage.storage().reference()
        let imageReference = storageRef.child(currentPrompt.promptImagePath)
        let placeholderImage = UIImage(named: "flower.jpg")
        promptImageView.sd_setImage(with: imageReference, placeholderImage: placeholderImage)
        
        promptTitleLabel.text = currentPrompt.promptTitle
        promptCommentLabel.text = currentPrompt.promptComment
        
        promptImageView.layer.borderWidth = 2
        promptImageView.layer.borderColor = UIColor.black.cgColor
        
//        navigationItem.titleView = UIImageView(image: UIImage(named:"hmwklogo1"))
        
        // Do any additional setup after loading the view.
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentPrompt.promptResponses.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "studentPromptResponseCell", for: indexPath) as! StudentPromptResponsesCollectionViewCell
        
        let responses = currentPrompt.promptResponses[indexPath.row]
        
        storageRef = Storage.storage().reference()
        let imageReference = storageRef.child(responses.responseImagePath)
        let placeholderImage = UIImage(named: "flower.jpg")
        cell.studentPromptResponseImageView.sd_setImage(with: imageReference, placeholderImage: placeholderImage)
        
        cell.studentPromptResponseImageView?.image = responses.image
        cell.studentPromptResponseLabel?.text = responses.comment
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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


