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
    let toolbar = UIToolbar()
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textField: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Заполняем Text Field и Text View
        self.titleField.text = noteItemsObject.titleNote
        self.textField.text = noteItemsObject.textNote
        
        // UIToolbar для textField
        let changeFont = UIBarButtonItem(image: UIImage(systemName: "textformat.size"), style: .plain, target: nil, action: #selector(showAlertChangeFont))
        
        let changeColor = UIBarButtonItem(image: UIImage(systemName: "eyedropper"), style: .plain, target: nil, action: nil)
        
        let chngeSize = UIBarButtonItem(image: UIImage(systemName: "shadow"), style: .plain, target: nil, action: nil )
        
        toolbar.sizeToFit()
        toolbar.setItems([.flexibleSpace().self ,changeFont,.flexibleSpace().self,changeColor,.flexibleSpace().self, chngeSize, .flexibleSpace().self], animated: true)
        textField.inputAccessoryView = toolbar
        toolbar.isHidden = false
        
        
    }
    
    // Меняем размер шрифта
    @objc func showAlertChangeFont()
    {
        let alert = UIAlertController(title: "Размер шрифта", message: nil, preferredStyle: .actionSheet)
        
        let firstAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Огромный", comment: "Default action"), style: .default) { action -> Void in
            self.textField.font = UIFont.systemFont(ofSize: 26)
        }
        
        let secondAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Средний", comment: "Default action"), style: .default) { action -> Void in
            self.textField.font = UIFont.systemFont(ofSize: 20)
        }
        
        let thirdAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Мелкий", comment: "Default action"), style: .default) { action -> Void in
            self.textField.font = UIFont.systemFont(ofSize: 16)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel) { action -> Void in }
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        alert.addAction(thirdAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
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
                let alert = UIAlertController(title: "Внимание!", message: "Заполните название и описание", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
}
