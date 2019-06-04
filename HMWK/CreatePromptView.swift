//
//  CreatePromptView.swift
//  HMWK
//
//  Created by Vincent Lewis on 5/17/19.
//  Copyright © 2019 HMWK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class CreatePromptView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var promptTitleLabel: UILabel!
    @IBOutlet weak var promptTitleTextField: UITextField!
    @IBOutlet weak var coursePicker: UIPickerView!
    @IBOutlet weak var promptImageLabel: UILabel!
    @IBOutlet weak var promptImageView: UIImageView!
    @IBOutlet weak var imagePickerButton: UIButton!
    @IBOutlet weak var promptSummaryTextField: UITextField!
    @IBOutlet weak var createPromptButton: UIButton!
    @IBOutlet weak var promptSummaryLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CreatePromptView",
                                 owner: self, options: nil)
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
