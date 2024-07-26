//
//  Note+CoreDataProperties.swift
//  Assignment 4 - Notes App 2
//
//  Created by Luka Khokhiashvili on 06.07.24.
//
//

import Foundation
import CoreData


extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var noteheader: String?
    @NSManaged public var notetext: String?

}

extension NoteEntity : Identifiable {

}
