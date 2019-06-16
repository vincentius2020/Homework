//
//  JoinCourseView.swift
//  HMWK
//
//  Created by Vincent Lewis on 6/16/19.
//  Copyright © 2019 HMWK. All rights reserved.
//

import UIKit

class JoinCourseView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var joinCourseLabel: UILabel!
    @IBOutlet weak var courseIDLabel: UILabel!
    @IBOutlet weak var courseIDTextField: UITextField!
    @IBOutlet weak var joinCourseButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        Bundle.main.loadNibNamed("JoinCourseView",
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
