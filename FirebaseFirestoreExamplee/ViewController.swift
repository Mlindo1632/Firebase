//
//  ViewController.swift
//  FirebaseFirestoreExamplee
//
//  Created by Khumalo, Lindokuhle L on 2023/10/17.
//
import FirebaseFirestore
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let database = Firestore.firestore()
    
    @IBOutlet var fTextfield: UITextField!
    @IBOutlet var mutattingFLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(fTextfield)
        view.addSubview(mutattingFLabel)
        fTextfield.delegate = self
        
        let docRef = database.document("Artist/Name")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            guard let text = data["text"] as? String else {
                return
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            saveData(text: text)
        }
        return true
    }
    
    func saveData(text:String){
        let docRef = database.document("Artist/Name")
        docRef.setData(["Artist": text])
    }

}

