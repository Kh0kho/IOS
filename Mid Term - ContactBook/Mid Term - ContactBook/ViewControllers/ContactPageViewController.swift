//
//  ContactPageViewController.swift
//  Mid Term - ContactBook
//
//  Created by Luka Khokhiashvili on 20.06.24.
//

import UIKit

class ContactPageViewController: UIViewController {
    
    private let contact: Contact
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .clear
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(contact: Contact) {
        self.contact = contact
        super.init(nibName: nil, bundle: nil) // Call the designated initializer of UIViewController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureGradientBackground()
        configureNavigationBar()
        configureMainView()

    }
    

    private func configureNavigationBar() {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = .white
        backButton.backgroundColor = .lightGray
        backButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        backButton.layer.cornerRadius = backButton.frame.height/2
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
        
        let editButton = UIButton(type: .system)
        editButton.setTitle("Edit", for: .normal)
        editButton.tintColor = .white
        editButton.backgroundColor = .lightGray
        editButton.frame = CGRect(x: 0, y: 0, width: 60, height: 35)
        editButton.layer.cornerRadius = editButton.frame.height/2
        let editBarButtonItem = UIBarButtonItem(customView: editButton)
        navigationItem.rightBarButtonItem = editBarButtonItem
    }
    
    @objc
    private func goBack() {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true

    }

    
    private func configureGradientBackground() {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = view.bounds
            gradientLayer.colors = [UIColor.systemGray.cgColor, UIColor.systemGray3.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0) // Bottom-left corner
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0) // Top-right corner
            view.layer.insertSublayer(gradientLayer, at: 0)
        }
    
    private func configureMainView(){
        let profileView = ProfileView(contact: contact)
        view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.widthAnchor.constraint(equalToConstant: 200),
            profileView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(nameLabel)
        nameLabel.text = "\(contact.firstName)  \(contact.lastName)"
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 30)
        ])
        
        configureIconsStack()
        
        configurePhoneNumberView()
   
    }
    
    private func configureIconsStack(){
        view.addSubview(iconsStack)
        NSLayoutConstraint.activate([
            iconsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            iconsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            iconsStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20)
        ])
        
        let messageIcon = ReusableButton(buttonName: "message.fill", title: "message")
        let phoneIcon = ReusableButton(buttonName: "phone.fill", title: "call")
        let mailIcon = ReusableButton(buttonName: "envelope.fill", title: "mail")
    
        iconsStack.addArrangedSubview(messageIcon)
        iconsStack.addArrangedSubview(phoneIcon)
        iconsStack.addArrangedSubview(mailIcon)
    }
    
    private func configurePhoneNumberView(){
        view.addSubview(whiteView)
        NSLayoutConstraint.activate([
            whiteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            whiteView.topAnchor.constraint(equalTo: iconsStack.bottomAnchor, constant: 20),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        whiteView.layer.cornerRadius = 10
        
        
        
        
        let phoneNumberStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.distribution = .fillProportionally
            stack.backgroundColor = .white
            stack.spacing = 5
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        let phoneTextLabel: UILabel = {
            let label = UILabel()
            label.text = "mobile"
            label.textColor = .black
            label.textAlignment = .left
            return label
        }()
        let phoneNumberLabel: UILabel = {
            let label = UILabel()
            label.text = contact.phoneNumber
            label.textColor = .systemBlue
            label.font = UIFont.systemFont(ofSize: 18)
            label.textAlignment = .left
            return label
        }()
        
        phoneNumberStack.addArrangedSubview(phoneTextLabel)
        phoneNumberStack.addArrangedSubview(phoneNumberLabel)
        
        whiteView.addSubview(phoneNumberStack)
        
        NSLayoutConstraint.activate([
            phoneNumberStack.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 10),
            phoneNumberStack.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -10),
            phoneNumberStack.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 20)
        ])
        
        phoneNumberStack.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        phoneNumberStack.isLayoutMarginsRelativeArrangement = true
        phoneNumberStack.layer.cornerRadius = 10
    }
    

}
