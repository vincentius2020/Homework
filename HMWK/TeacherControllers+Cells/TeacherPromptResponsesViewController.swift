//
//  TeacherPromptResponsesViewController.swift
//  HMWK
//
//  Created by Vincent Lewis on 12/20/18.
//  Copyright © 2018 HMWK. All rights reserved.
//

import UIKit
import Firebase

class TeacherPromptResponsesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var teacherPromptResponsesCollectionView: UICollectionView!
    @IBOutlet weak var promptImageView: UIImageView!
    @IBOutlet weak var promptTitleLabel: UILabel!
    @IBOutlet weak var promptCommentLabel: UILabel!
    
    var currentPrompt: Prompt!
    var storageRef: StorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teacherPromptResponsesCollectionView.dataSource = self
        teacherPromptResponsesCollectionView.delegate = self
        
        let layout = self.teacherPromptResponsesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.teacherPromptResponsesCollectionView.frame.size.width)/2, height: (self.teacherPromptResponsesCollectionView.frame.size.height/2.5))
        
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentPrompt.promptResponses.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teacherPromptResponseCell", for: indexPath) as! TeacherPromptResponsesCollectionViewCell
        
        let responses = currentPrompt.promptResponses[indexPath.row]
        
        storageRef = Storage.storage().reference()
        let imageReference = storageRef.child(responses.responseImagePath)
        let placeholderImage = UIImage(named: "flower.jpg")
        cell.teacherPromptResponseImageView.sd_setImage(with: imageReference, placeholderImage: placeholderImage)
        
        cell.teacherPromptResponseLabel?.text = responses.comment
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
        
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

//func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "studentPromptResponseCell", for: indexPath) as! StudentPromptResponsesCollectionViewCell
//
//    let response = currentPrompt.promptResponses[indexPath.row]
//
//    cell.studentPromptResponseImageView?.image = response.image
//    cell.studentPromptResponseLabel?.text = response.comment
//
//    cell.layer.borderColor = UIColor.lightGray.cgColor
//    cell.layer.borderWidth = 0.5
//
//    return cell
//
//}
//
//
//override func didReceiveMemoryWarning() {
//    super.didReceiveMemoryWarning()
//}
