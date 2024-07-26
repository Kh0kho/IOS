//
//  ViewController.swift
//  Mid Term - ContactBook
//
//  Created by Luka Khokhiashvili on 19.06.24.
//

import UIKit

class ViewController: UIViewController {
    
    private let NoContactsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.backgroundColor = .clear
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let contactsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        configureNavigationBar()
        configureNoContactsView()
        configureContactsTableView()
        configureCenterView()
    }
    
    func configureCenterView(){
        print(contactsData.count)
        if contactsData.count == 0{
            contactsTableView.isHidden = true
            NoContactsStack.isHidden = false
        }
        else{
            contactsTableView.isHidden = false
            NoContactsStack.isHidden = true
        }
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(handleAdd)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: nil)
    }
    
    @objc
    private func handleAdd() {
        let addContactViewController = AddContactViewController(delegate: self)
        let navigationController = UINavigationController(rootViewController: addContactViewController)
        present(navigationController, animated: true)
        print("add")
    }
    
    private func configureNoContactsView() {
        let profileImage: UIImageView = {
            let image = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
            image.tintColor = .systemGray
            
            return image
        }()
        let headerLabel: UILabel = {
            let label = UILabel()
            label.text = "No Contacts"
            label.textColor = .black
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 24)
            return label
        }()
        let label: UILabel = {
            let label = UILabel()
            label.text = "Contacts you've added will appere here"
            label.textColor = .lightGray
            label.textAlignment = .center
            return label
        }()
        let createButton: UIButton = {
            let button = UIButton()
            button.setTitle("Create New Contact", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
            return button
        }()
        
        view.addSubview(NoContactsStack)
        NSLayoutConstraint.activate([
            NoContactsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            NoContactsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            NoContactsStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
            
        ])
//        NoContactsStack.addArrangedSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100)
        ])
        NoContactsStack.addArrangedSubview(headerLabel)
        NoContactsStack.addArrangedSubview(label)
        NoContactsStack.addArrangedSubview(createButton)
        
    }
    
    @objc private func createButtonTapped(_ sender: UIButton) {
        let addContactViewController = AddContactViewController(delegate: self)
        let navigationController = UINavigationController(rootViewController: addContactViewController)
        present(navigationController, animated: true)
    }
    
    private func configureContactsTableView() {
        view.addSubview(contactsTableView)
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        contactsTableView.backgroundColor = .clear
        
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contactsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contactsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contactsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        contactsTableView.separatorStyle = .singleLine
        contactsTableView.separatorColor = .systemGray3
        contactsTableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
    }
    
    private func findIndexForSection(section: String) -> Int {
        var ourIndex = -1
        for (index, _) in contactsData.enumerated() {
            let song = contactsData[index].first { $0.section == section }
        
            if song != nil {
                ourIndex = index
            }
        }
        return ourIndex
    }

}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        contactsData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        print(indexPath)
        print(contactsData)
        cell.configure(contact: contactsData[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        contactsData[section].first?.section
    }
    
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //ეს ვერ გავასწორე ნორმალურად რო ქრებოდეს largeTitle-ი
//        navigationController?.navigationBar.prefersLargeTitles = false
        let contactPageViewController = ContactPageViewController(contact: contactsData[indexPath.section][indexPath.row])
        navigationController?.pushViewController(contactPageViewController, animated: true)

    }
}


