//
//  TeacherCoursePromptsViewController.swift
//  HMWK
//
//  Created by Vincent Lewis on 12/13/18.
//  Copyright © 2018 HMWK. All rights reserved.
//

import UIKit
import Firebase

class TeacherCoursePromptsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var teacherCoursePromptsCollectionView: UICollectionView!
    @IBOutlet weak var courseImageView: UIImageView!
    @IBOutlet weak var courseTitleLabel: UILabel!
    
    var currentCourse: Course!
    var selectedPrompt: Prompt?
    var storageRef: StorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teacherCoursePromptsCollectionView.dataSource = self
        teacherCoursePromptsCollectionView.delegate = self
        
        ReadFirebaseData.readCourse(courseId: currentCourse.courseID, completion: {(success) in
            if success {
                self.teacherCoursePromptsCollectionView.reloadData()
            } else {
                print("Errrrrr")
            }
        })
        
        let layout = self.teacherCoursePromptsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.teacherCoursePromptsCollectionView.frame.size.width)/2, height: (self.teacherCoursePromptsCollectionView.frame.size.height/2.5))
        
        storageRef = Storage.storage().reference()
        let imageReference = storageRef.child(currentCourse.courseImagePath)
        let placeholderImage = UIImage(named: "flower.jpg")
        courseImageView.sd_setImage(with: imageReference, placeholderImage: placeholderImage)
        

        courseTitleLabel.text = currentCourse.courseName
        
        courseImageView.layer.cornerRadius = courseImageView.frame.size.width/2
        
        courseImageView.layer.borderWidth = 2
        courseImageView.layer.borderColor = UIColor.black.cgColor
        
//        navigationItem.titleView = UIImageView(image: UIImage(named:"hmwklogo1"))
        
        // Do any additional setup after loading the view.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentCourse.coursePrompts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teacherCoursePromptCell", for: indexPath) as! TeacherCoursePromptsCollectionViewCell
        
        let prompt = currentCourse.coursePrompts[indexPath.row]
        
        storageRef = Storage.storage().reference()
        let imageReference = storageRef.child(prompt.promptImagePath)
        let placeholderImage = UIImage(named: "flower.jpg")
        cell.teacherCoursePromptImage.sd_setImage(with: imageReference, placeholderImage: placeholderImage)
                
        cell.teacherCoursePromptLabel?.text = prompt.promptTitle
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPrompt = currentCourse.coursePrompts[indexPath.row]
        
        self.performSegue(withIdentifier: "teacherCPR", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "teacherCPR") {
            if let newVC = segue.destination as? TeacherCPRViewController {
                newVC.currentPrompt = selectedPrompt
            }
        }
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

