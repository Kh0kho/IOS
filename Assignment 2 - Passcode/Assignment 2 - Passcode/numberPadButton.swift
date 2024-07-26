//
//  numberPadButton.swift
//  Assignment 2 - Passcode
//
//  Created by Luka Khokhiashvili on 07.06.24.
//

import UIKit

class numberPadButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let num: String
    private let letters: String
    private let numLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = label.font.withSize(26)
        label.textAlignment = .center
        return label
    }()
    private let lettersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = label.font.withSize(8)
        label.textAlignment = .center
        return label
    }()
    private let buttonStackView: UIStackView = {
        let SV = UIStackView()
        SV.axis = .vertical
        SV.distribution = .fillEqually
        SV.spacing = -35
        SV.isUserInteractionEnabled = false
        return SV
    }()
    
    init(num: String, letters: String){
        self.num = num
        self.letters = letters
        super.init(frame: .zero)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    
    private func setUp(){
        numLabel.text = num
        lettersLabel.text = letters
        buttonStackView.addArrangedSubview(numLabel)
        if (letters != ""){
            buttonStackView.addArrangedSubview(lettersLabel)
        }
        addSubview(buttonStackView)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonStackView.topAnchor.constraint(equalTo: self.topAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        border()

    }
    
    @objc func buttonTapped() {
            print(num)
        }
    

}
