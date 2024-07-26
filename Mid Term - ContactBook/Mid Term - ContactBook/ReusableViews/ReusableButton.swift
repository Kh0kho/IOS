//
//  ReusableButton.swift
//  Mid Term - ContactBook
//
//  Created by Luka Khokhiashvili on 25.06.24.
//

import UIKit

class ReusableButton: UIButton {

    private let buttonName: String
    private let title: String
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = label.font.withSize(16)
        label.textAlignment = .center
        return label
    }()
    private let buttonStackView: UIStackView = {
        let SV = UIStackView()
        SV.axis = .vertical
        SV.distribution = .fillEqually
        SV.spacing = 5
        SV.isUserInteractionEnabled = false
        return SV
    }()
    
    init(buttonName: String, title: String){
        self.buttonName = buttonName
        self.title = title
        super.init(frame: .zero)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    
    private func setUp(){
        label.text = title
        let iconview = UIView()
        let icon: UIImageView = {
            let image = UIImageView(image: UIImage(systemName: buttonName))
            image.translatesAutoresizingMaskIntoConstraints = false
            image.tintColor = .white
            return image
        }()
        iconview.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: iconview.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: iconview.centerYAnchor)
        ])
        buttonStackView.addArrangedSubview(iconview)
        buttonStackView.addArrangedSubview(label)
        addSubview(buttonStackView)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
//        backgroundColor = UIColor(red: 123/255.0, green: 126/255.0, blue: 139/255.0, alpha: 1.0)
        backgroundColor = .systemGray
        layer.cornerRadius = 10

    }
    
    

}

