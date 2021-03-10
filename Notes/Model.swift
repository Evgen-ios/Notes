//
//  Model.swift
//  Notes
//
//  Created by Evgeniy Goncharov on 06.03.2021.
//

import Foundation
import RealmSwift

// Класс с обьектами
class NoteItems: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var titleNote = ""
    @objc dynamic var dateNote = ""
    @objc dynamic var textNote = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}

// Инициализируем БД
let realm = try! Realm()
var items: Results<NoteItems>!

// Добавляем запись в БД
func addItem(titleNote: String, dateNote: String = Timestamp(), textNote: String) {
    let noteAdd = NoteItems(value: ["titleNote": titleNote, "dateNote": dateNote, "textNote": textNote])
    try! realm.write {
        realm.add(noteAdd)
        print("ADD \(noteAdd)")
    }
}

// Удаляем запись из БД
func removeItem(at index: ObjectBase){
    try! realm.write {
        realm.delete(index)
    }
}

// Обновляем запись в БД
func updateItem(titleNote: String, dateNote: String = Timestamp(), textNote: String, id: String) {
    let noteAdd = NoteItems(value: ["id":id,"titleNote": titleNote, "dateNote": dateNote, "textNote": textNote])
    try! realm.write {
        realm.add(noteAdd, update: .modified)
        print("EDIT \(noteAdd)")
    }
}

// Текущая дата и время
func Timestamp() -> String {
    let curretDateStamp =  DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .long, timeStyle: .short)
    //print(curretDateStamp)
    return curretDateStamp
}

// Добавляем одну заметку при первом запуске приложения
func addFirstItem(){
    if !UserDefaults.standard.bool(forKey: "FirstStart") {
        addItem(titleNote: "Заметка для тестирования", textNote: "При первом запуске, приложение должно иметь одну заметку с текстом.")
        UserDefaults.standard.set(true, forKey: "FirstStart")
    }
}
