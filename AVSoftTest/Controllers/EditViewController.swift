//
//  EditViewController.swift
//  AVSoftTest
//
//  Created by Timur Khamzin on 06.03.2020.
//  Copyright © 2020 Timur Khamzin. All rights reserved.
//

import UIKit
import Photos
import AVFoundation
import Foundation
import RealmSwift

class EditViewController: UIViewController {
    
    var avatar = UIImage()
    var person = Person()
    var imageData = Data()
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var nationalyTextField: UITextField!
    
    @IBOutlet weak var textviewDescription: UITextView!
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var imagePerson: UIImageView!
    @IBOutlet weak var editOutlet: UIButton!
    
    @IBOutlet weak var formStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var storageManager = StorageManager()
    var details = ShowTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.isEnabled = false
        ageTextField.isEnabled = false
        sexTextField.isEnabled = false
        nationalyTextField.isEnabled = false
        textviewDescription.isEditable = false
        addPhotoButton.isHidden = true
        saveButtonOutlet.isEnabled = false
        
        
        self.nationalyTextField.text = person.nationality
        self.nameTextField.text = person.name
        self.ageTextField.text = String(person.age)
        self.sexTextField.text = person.sex
        self.imagePerson.image = UIImage(data: person.image) ?? UIImage(named: "Image")
        
        setupToHideKeyboardOnTapOnView()
        settingsToScrollAndStackViews()

        // Do any additional setup after loading the view.
    }
    
    func settingsToScrollAndStackViews() {
        self.scrollView.addSubview(formStackView)
        self.formStackView.translatesAutoresizingMaskIntoConstraints = true
        self.formStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.formStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.formStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.formStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.formStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    
    @IBAction func addPhotoButton(_ sender: Any) {
        let alert = UIAlertController(title: "Прикрепить фото", message: "", preferredStyle: .actionSheet)
        
        let galleryAction = UIAlertAction(title: "Галерея", style: .default) { (action) in
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion:  nil)
        }
        
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        editOutlet.isHidden = false
        nameTextField.isEnabled = false
        ageTextField.isEnabled = false
        sexTextField.isEnabled = false
        nationalyTextField.isEnabled = false
        textviewDescription.isEditable = false
        
        try! realm.write {
            person.name = nameTextField.text!
            person.humanDescription = textviewDescription.text!
            person.sex = sexTextField.text!
            person.age = Int(ageTextField.text!) ?? 0
            person.image = imageData
            
        }
        
        saveButtonOutlet.isHidden = true
        addPhotoButton.isHidden = true
        imagePerson.alpha = 1
        
    }
    
    
    @IBAction func editAction(_ sender: Any) {
        
        editOutlet.isHidden = true
        nameTextField.isEnabled = true
        ageTextField.isEnabled = true
        sexTextField.isEnabled = true
        nationalyTextField.isEnabled = true
        textviewDescription.isEditable = true
        
        saveButtonOutlet.isEnabled = true
        saveButtonOutlet.isHidden = false
        
        addPhotoButton.isHidden = false
        imagePerson.alpha = 0.5
        
    }

}


extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let imageFromPickerController = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            
            self.imageData = imageFromPickerController.pngData()!
            avatar = UIImage(data: imageData)!
            imagePerson.image = UIImage(data: imageData)
            self.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
        
        func setupToHideKeyboardOnTapOnView() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(EditViewController.dismissKeyboard))
            
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
        
    }
