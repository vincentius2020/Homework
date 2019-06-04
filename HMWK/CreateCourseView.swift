//
//  CreateCourseView.swift
//  HMWK
//
//  Created by Vincent Lewis on 5/16/19.
//  Copyright © 2019 HMWK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class CreateCourseView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var courseTitleTextField: UITextField!
    @IBOutlet weak var courseImageLabel: UILabel!
    @IBOutlet weak var courseImageView: UIImageView!
    @IBOutlet weak var createCourseButton: UIButton!
    @IBOutlet weak var imagePickerButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CreateCourseView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


}
