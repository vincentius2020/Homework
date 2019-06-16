//
//  CreateResponseView.swift
//  HMWK
//
//  Created by Vincent Lewis on 6/16/19.
//  Copyright © 2019 HMWK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class CreateResponseView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var newResponseLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var responseImageView: UIImageView!
    @IBOutlet weak var imagePickerButton: UIButton!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var explanationTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CreateResponseView",
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
