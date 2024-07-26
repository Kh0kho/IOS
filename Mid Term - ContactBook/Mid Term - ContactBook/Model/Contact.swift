//
//  Contact.swift
//  Mid Term - ContactBook
//
//  Created by Luka Khokhiashvili on 24.06.24.
//

import Foundation

class Contact {
    let firstName: String
    let lastName: String
    let phoneNumber: String
    var section = ""
    init(firstName: String, lastName: String, phoneNumber: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.section = String(lastName.prefix(1)).uppercased()
    }
}

var contactsData: [[Contact]] = [
]


func addContact(newContact: Contact) {
    let section = newContact.section

    var sectionFound = false
    for i in 0..<contactsData.count {
        if let firstContactInSection = contactsData[i].first, firstContactInSection.section == section {
            var inserted = false
            for j in 0..<contactsData[i].count {
                if contactsData[i][j].lastName > newContact.lastName {
                    contactsData[i].insert(newContact, at: j)
                    inserted = true
                    break
                }
            }
            if !inserted {
                contactsData[i].append(newContact)
            }
            sectionFound = true
            break
        }
    }

    if !sectionFound {
        contactsData.append([newContact])
        contactsData.sort { $0.first!.section < $1.first!.section }
    }
}


