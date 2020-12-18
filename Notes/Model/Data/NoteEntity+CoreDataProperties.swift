//
//  NoteEntity+CoreDataProperties.swift
//  Notes
//
//  Created by Арман on 11/12/20.
//  Copyright © 2020 Арман. All rights reserved.
//
//

import Foundation
import CoreData


extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var colorTag: Int16
    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var title: String?

}

extension NoteEntity : Identifiable {

}
