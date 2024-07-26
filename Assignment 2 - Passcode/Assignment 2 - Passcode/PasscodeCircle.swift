//
//  PasscodeCircle.swift
//  Assignment 2 - Passcode
//
//  Created by Luka Khokhiashvili on 11.06.24.
//

import UIKit

class PasscodeCircle: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    init(){
        super.init(frame: .zero)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    private func setUp(){
        backgroundColor = .clear
        border()
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
    }

}
