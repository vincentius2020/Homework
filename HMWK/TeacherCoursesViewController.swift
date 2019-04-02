//
//  TeacherCoursesViewController.swift
//  HMWK
//
//  Created by Vincent Lewis on 9/7/18.
//  Copyright © 2018 HMWK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class TeacherCoursesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var teacherCoursesCollectionView: UICollectionView!
    
    var selectedCourse: Course?
    var storageRef: StorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ReadFirebaseData.readCurrentUserWithCourses(userId: (FirebaseData.data.currentUser?.userEmail)!, completion: {(success) in
            if success {
                print ("successfully wrote user")
                
                FirebaseData.data.enrolledCourses = FirebaseData.data.currentUser?.enrolledCourses
                    
                }
            }
        )
        
        teacherCoursesCollectionView.dataSource = self
        teacherCoursesCollectionView.delegate = self
        
        let layout = self.teacherCoursesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.teacherCoursesCollectionView.frame.size.width)/2, height: (self.teacherCoursesCollectionView.frame.size.height/3))
        
        // Do any additional setup after loading the view.
        
//        navigationItem.titleView = UIImageView(image: UIImage(named: "hmwklogo1"))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return Singleton.singletonObject.allCourses!.count
        return FirebaseData.data.enrolledCourses!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teacherCourseCell", for: indexPath) as! TeacherCourseCellCollectionViewCell
        
        let course = FirebaseData.data.enrolledCourses?[indexPath.row]
        
//        let prompt = Singleton.singletonObject.allPrompts?.first(where: { $0.promptID == response?.promptID })
        
        storageRef = Storage.storage().reference()
        let imageReference = storageRef.child(course!.courseImagePath)
        let placeholderImage = UIImage(named: "flower.jpg")
        cell.teacherCourseCellImageView.sd_setImage(with: imageReference, placeholderImage: placeholderImage)

//        cell.teacherCourseCellImageView?.image = course?.courseImage
        
        cell.teacherCourseCellLabel?.text = course?.courseName

        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedCourse = Singleton.singletonObject.allCourses?[indexPath.row]
        selectedCourse = FirebaseData.data.enrolledCourses?[indexPath.row]
        
        self.performSegue(withIdentifier: "teacherCourseToPrompt", sender: self)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "teacherCourseToPrompt") {
            if let newVC = segue.destination as? TeacherCoursePromptsViewController {
                newVC.currentCourse = selectedCourse
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

//func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    selectedCourse = Singleton.singletonObject.studentUser1Courses?[indexPath.row]
//
//    self.performSegue(withIdentifier: "studentCourseToPrompt", sender: self)
//}
//
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if (segue.identifier == "studentCourseToPrompt") {
//        if let newVC = segue.destination as? StudentCoursePromptsViewController {
//            newVC.currentCourse = selectedCourse
//        }
//    }
//}
