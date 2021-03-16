//
//  CloseButton.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 08/03/21.
//

import Foundation
import UIKit


final class CloseButton: UIButton {

    var height = 30
    var width = 30
    override init(frame: CGRect){
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
       // fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    func setup() {
        self.clipsToBounds = true
        self.setImage(UIImage(named: "close_icon.png"), for: UIControl.State.normal)
    }
}

