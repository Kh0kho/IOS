//
//  AddContactViewController.swift
//  Mid Term - ContactBook
//
//  Created by Luka Khokhiashvili on 20.06.24.
//

import UIKit

class AddContactViewController: UIViewController {
    private var delegate: ViewController
    
    init(delegate: ViewController) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let profileImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        image.tintColor = .systemGray
        
        return image
    }()
    
    let fieldsTableView = UITableView()
    
    private var firstName: String?
    private var lastName: String?
    private var phoneNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray6
        
        configureNavigationBar()
        configureProfileImage()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "New Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancel)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(done)
        )
        
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc
    private func done() {
        
        addContact(newContact: Contact(firstName: firstName!, lastName: lastName!, phoneNumber: phoneNumber!))
        dismiss(animated: true, completion: nil)
        delegate.configureCenterView()
        delegate.contactsTableView.reloadData()
    }
    
    private func findIndexForSection(section: String) -> Int {
        var ourIndex = -1
        for (index, _) in contactsData.enumerated() {
            let contact = contactsData[index].first { $0.section == section }
        
            if contact != nil {
                ourIndex = index
            }
        }
        return ourIndex
    }
    
    
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    private func configureProfileImage() {
        view.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 200),
            profileImage.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
    private func configureTableView(){
        view.addSubview(fieldsTableView)
        
        fieldsTableView.delegate = self
        fieldsTableView.dataSource = self
        
        fieldsTableView.backgroundColor = .clear
        
        fieldsTableView.isScrollEnabled = false
        
        fieldsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fieldsTableView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 30),
            fieldsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            fieldsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            fieldsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        fieldsTableView.separatorStyle = .singleLine
        fieldsTableView.separatorColor = .systemGray3
//        fieldsTableView.layer.borderColor = UIColor.systemGray3.cgColor
//        fieldsTableView.layer.borderWidth = 0.5
        
        fieldsTableView.register(TextFieldCell.self, forCellReuseIdentifier: "TextFieldCell")

    }
    
    @objc 
    private func handleFirstNameChange(_ sender: UITextField){
        firstName = sender.text
        checkFields()
    }
    @objc
    private func handleLastNameChange(_ sender: UITextField){
        lastName = sender.text
        checkFields()
    }
    @objc
    private func handlePhoneNumberChange(_ sender: UITextField){
        phoneNumber = sender.text
        checkFields()
    }
    
    
    private func checkFields(){
        if let firstName = firstName, let lastName = lastName, let phoneNumber = phoneNumber,
           !firstName.isEmpty, !lastName.isEmpty, !phoneNumber.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}


extension AddContactViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as? TextFieldCell else {
               return UITableViewCell()
           }
           
           switch indexPath.row {
           case 0:
               cell.textField.placeholder = "First Name"
               cell.textField.addTarget(
                self,
                action: #selector(handleFirstNameChange),
                for: .editingChanged
               )
           case 1:
               cell.textField.placeholder = "Last Name"
               cell.textField.addTarget(
                self,
                action: #selector(handleLastNameChange),
                for: .editingChanged
               )
           case 2:
               cell.textField.placeholder = "Phone Number"
               cell.textField.keyboardType = .numberPad
               cell.textField.addTarget(
                self,
                action: #selector(handlePhoneNumberChange),
                for: .editingChanged
               )
           default:
               break
           }
           
           return cell
       }
    
}


extension AddContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
