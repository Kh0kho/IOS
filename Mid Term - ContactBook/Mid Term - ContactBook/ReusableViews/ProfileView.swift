//
//  ProfileView.swift
//  Mid Term - ContactBook
//
//  Created by Luka Khokhiashvili on 24.06.24.
//

import UIKit

class ProfileView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private let cotnact: Contact
    private let initialsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    init(contact: Contact){
        self.cotnact = contact
        super.init(frame: .zero)
        initialsLabel.text = "\(contact.firstName.prefix(1))\(contact.lastName.prefix(1))"
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {

        backgroundColor = UIColor(red: 150/255.0, green: 155/255.0, blue: 165/255.0, alpha: 1.0)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(initialsLabel)
        
        NSLayoutConstraint.activate([
            initialsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            initialsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        layer.cornerRadius = 100
        
    }

}
