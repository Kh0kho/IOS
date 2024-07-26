//
//  ContactCellTableViewCell.swift
//  Mid Term - ContactBook
//
//  Created by Luka Khokhiashvili on 24.06.24.
//

import UIKit

class ContactCell: UITableViewCell {

    var contact: Contact?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(contact: Contact) {
        self.contact = contact

        let firstName = contact.firstName
        let lastName = contact.lastName

        let fullName = "\(firstName) \(lastName)"

        let attributedText = NSMutableAttributedString(string: fullName)

        let fullNameRange = (fullName as NSString).range(of: fullName)
        let lastNameRange = (fullName as NSString).range(of: lastName, options: .backwards, range: fullNameRange)

        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: lastNameRange)

        self.textLabel?.attributedText = attributedText
    }

}
