//
//  Note.swift
//  Notes
//
//  Created by Арман on 3/7/20.
//  Copyright © 2020 Арман. All rights reserved.
//

import Foundation

enum Colors: Int {
    case red = 1, blue, green, purple
}


class Note {
    var title: String?
    var text: String?
    var date: Date?
    var colorTag: Colors?
    
    init(title: String?, text: String?, date: Date?, colorTag: Colors?) {
        self.title = title
        self.text = text
        self.date = date
        self.colorTag = colorTag
    }
}
