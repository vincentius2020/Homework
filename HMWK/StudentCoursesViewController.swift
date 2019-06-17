//
//  StudentCoursesViewController.swift
//  HMWK
//
//  Created by Vincent Lewis on 11/21/18.
//  Copyright © 2018 HMWK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class StudentCoursesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var studentCoursesCollectionView: UICollectionView!
    @IBOutlet weak var joinCourseView: JoinCourseView!
    @IBOutlet weak var addCourseButton: UIButton!
    
    
    var selectedCourse: Course?
    var storageRef: StorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentCoursesCollectionView.dataSource = self
        studentCoursesCollectionView.delegate = self
        
        joinCourseView.joinCourseLabel.text = "Join a Course"
        joinCourseView.courseIDLabel.text = "Course ID"
        joinCourseView.courseIDTextField.delegate = self
        
        joinCourseView.joinCourseButton.layer.cornerRadius = joinCourseView.joinCourseButton.frame.size.width/20
        joinCourseView.joinCourseButton.layer.borderWidth = 0.5
        joinCourseView.joinCourseButton.layer.borderColor = UIColor.black.cgColor
        
        let layout = self.studentCoursesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.studentCoursesCollectionView.frame.size.width)/2, height: (self.studentCoursesCollectionView.frame.size.height/3))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return Singleton.singletonObject.allCourses!.count
        return FirebaseData.data.enrolledCourses!.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "studentCourseCell", for: indexPath) as! StudentCoursesCollectionViewCell
        
//        let course = Singleton.singletonObject.allCourses?[indexPath.row]
        let course = FirebaseData.data.enrolledCourses?[indexPath.row]
        
        //        let prompt = Singleton.singletonObject.allPrompts?.first(where: { $0.promptID == response?.promptID })
        
        storageRef = Storage.storage().reference()
        let imageReference = storageRef.child(course!.courseImagePath)
        let placeholderImage = UIImage(named: "flower.jpg")
        cell.studentCourseCellImageView.sd_setImage(with: imageReference, placeholderImage: placeholderImage)
        
        cell.studentCourseCellLabel?.text = course?.courseName
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCourse = FirebaseData.data.enrolledCourses![indexPath.row]
                
        self.performSegue(withIdentifier: "studentCourseToPrompts", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "studentCourseToPrompts") {
            if let newVC = segue.destination as? StudentCoursePromptsViewController {
            newVC.currentCourse = selectedCourse
            }
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
