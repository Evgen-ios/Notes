//
//  NoteViewController.swift
//  Notes
//
//  Created by Evgeniy Goncharov on 07.03.2021.
//

import UIKit
import RealmSwift

class NoteViewController: UIViewController {
    
    // Экземпляр класса NotesItems
    var noteItemsObject = NoteItems()
    
    var segue: Bool!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Заполняем Text Field и Text View
        self.titleField.text = noteItemsObject.titleNote
        self.textField.text = noteItemsObject.textNote
    }
    
    // Нажимаем кнопку готово
    @IBAction func tapSave(_ sender: Any) {
        
        if segue == true {
            
            // Обновляем запись в БД по id
            updateItem(titleNote: titleField.text!, textNote: textField.text, id: noteItemsObject.id)
        } else {
            if !titleField.text!.isEmpty && !textField.text!.isEmpty {
                
                // Добавляем новую запись в БД
                addItem(titleNote: titleField.text!, textNote: textField.text)
            } else {
                
                // Алерт с ошибкой если есть пустой обьект
                let alert = UIAlertController(title: "Внимание", message: "Заполните все поля пожалуйста!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
}
