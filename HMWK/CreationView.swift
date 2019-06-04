//
//  CreationView.swift
//  HMWK
//
//  Created by Vincent Lewis on 4/16/19.
//  Copyright © 2019 HMWK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class CreationView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageLabel: UILabel!
    
    override init(frame: CGRect) { 
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CreationView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
