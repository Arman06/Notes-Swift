//
//  Data.swift
//  Notes
//
//  Created by Арман on 11/12/20.
//  Copyright © 2020 Арман. All rights reserved.
//

import UIKit
import CoreData

final class DataService {
    static let instance = DataService()
    var dates = [Date]()
    
    init() {
        var allNotes = [NoteEntity]()
        do {
            allNotes = try context.fetch(NoteEntity.fetchRequest())
        } catch let error as NSError {
            print("Fetching Problem: \(error)")
        }

        for note in allNotes {
            dates.append((note.date! as Date).stripTime())
            notesArray[note.date! as Date]?.append(note)
        }
        for date in dates {
            var array = [NoteEntity]()
            for note in allNotes {
                if (note.date! as Date).stripTime() == date {
                    array.append(note)
                }
            }
            notesArray[date] = array.reversed()
        }
    }
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistenceContainer.viewContext
    
    
    var currentDate: Date { return Date() }
    
    private var dateArray: [Date]  { return Array(self.notesArray.keys.sorted(by: >)) }
    
    
    lazy private var notesArray = [currentDate.stripTime():[NoteEntity]()]
   
   
    
    func addNote(_ note: Note) {
        let noteDataItem = NoteEntity(entity: NoteEntity.entity(), insertInto: context)
        noteDataItem.title = note.title
        noteDataItem.text = note.text
        noteDataItem.colorTag = Int16(note.colorTag!.rawValue)
        noteDataItem.date = note.date
        if (notesArray[note.date!] != nil) {
            notesArray[note.date!]!.insert(noteDataItem, at: 0)
        } else {
            notesArray[note.date!] = [noteDataItem]
        }
        print(dateArray)
        appDelegate.saveContext()
    }
    
    func updateNote(at indexPath: IndexPath, to title: String, with text: String) {
        notesArray[dateArray[indexPath.section]]![indexPath.row].setValue(title, forKey: "title")
        notesArray[dateArray[indexPath.section]]![indexPath.row].setValue(text, forKey: "text")
//        var allNotes = [NoteEntity]()
//        do {
//            allNotes = try context.fetch(NoteEntity.fetchRequest())
//        } catch let error as NSError {
//            print("Fetching Problem: \(error)")
//        }
//
//        for note in allNotes {
//            dates.append((note.date! as Date).stripTime())
//            notesArray[note.date! as Date]?.append(note)
//        }
        appDelegate.saveContext()
    }
    
    func removeNote(at indexPath: IndexPath) {
        context.delete(notesArray[dateArray[indexPath.section]]![indexPath.row])
        notesArray[dateArray[indexPath.section]]!.remove(at: indexPath.row)
        appDelegate.saveContext()
    }
    
    func removeNote(_ array: [NoteEntity]) -> [IndexPath] {
        var index = [IndexPath]()
        for selectedItem in array {
            for date in dateArray {
                if let selectedIndex = notesArray[date]!.firstIndex(of: selectedItem) {
                    index.append(IndexPath(row: selectedIndex, section: dateArray.firstIndex(of: date)!))
                }
            }
        }
        
        for selectedItem in array {
            for date in dateArray {
                if let selectedIndex = notesArray[date]!.firstIndex(of: selectedItem) {
                    context.delete(notesArray[date]![selectedIndex])
                    notesArray[date]!.remove(at: selectedIndex)
                }
            }
        }
        appDelegate.saveContext()
        return index
        
    }
    
    func getNotes() -> [Note] {
        return Array(notesArray.values).flatMap{ $0 }.map { Note(title: $0.title,
                                                                 text: $0.text,
                                                                 date: $0.date,
                                                                 colorTag: Colors(rawValue: Int($0.colorTag)))}
    }
    
    func getDates() -> [Date] {
        return dateArray
    }
    
    func getNotes(for section: Int) -> [Note] {
        return notesArray[dateArray[section], default: [NoteEntity]()].map {
                                                        Note(title: $0.title,
                                                             text: $0.text,
                                                             date: $0.date,
                                                             colorTag: Colors(rawValue: Int($0.colorTag)))}
    }
    
    func getNoteTitles() -> [String] {
        return Array(notesArray.values).flatMap{ $0 }.map{ $0.title ?? "Без имени" }
    }
    
    func numberOfSections() -> Int {
        return dateArray.count
    }
    
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return getNotes(for: section).count
    }
    
    func numberOfItemsInSections() -> Int {
        return Array(notesArray.values).flatMap{ $0 }.count
    }

    private func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return " \(dateFormatter.string(from: date))"
    }
    
    func stringDateFor(for indexPath: IndexPath) -> String {
        return dateToString(dateArray[indexPath.section])
    }
    
}



