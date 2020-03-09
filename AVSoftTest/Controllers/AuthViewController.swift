//
//  AuthViewController.swift
//  AVSoftTest
//
//  Created by Timur Khamzin on 04.03.2020.
//  Copyright © 2020 Timur Khamzin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AuthViewController: UIViewController {
    
    let progress = Progress(totalUnitCount: 2)
    
    var signUp: Bool = true {
        willSet{
            if newValue{
                titleLabel.text = "Регистрация"
                nameTextField.isHidden = false
                enterButton.setTitle("Войти", for: .normal)
                progressViewOutlet.isHidden = true
                
            } else {
                
                titleLabel.text = "Вход"
                nameTextField.isHidden = true
                enterButton.setTitle("Регистрация", for: .normal)
                progressViewOutlet.isHidden = false
            }
        }
    }
    
    @IBOutlet weak var progressViewOutlet: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        progressViewOutlet.isHidden = true
        
    }
    
    
    
    
    @IBAction func enterAction(_ sender: Any) {
        signUp = !signUp
    }
    
    @IBAction func enterActionWithProgressBar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //создание метода для полосы загрузки - Progress View
    func createNewLine() {
        
        Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { (timer) in
                     guard self.progress.isFinished == false else {
                       timer.invalidate()
                         print("finished")
                         return
               }
                     self.progress.completedUnitCount += 1

                     let progressFloat = Float(self.progress.fractionCompleted)
                     self.progressViewOutlet.setProgress(progressFloat, animated: true)
                 }
        }
    
    // создание Алерта - если поля не заполнены
    func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let name = nameTextField.text!
        
        
        //проверка соотвестивие данных авторизации
        
        
        if(signUp){
            if(!name.isEmpty && !email.isEmpty && !password.isEmpty){
                Auth.auth().createUser(withEmail: email, password: password) {(result, error) in
                    if error == nil {
                            if let result = result {
                            print(result.user.uid)
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["name": name, "email" : email])
                                self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }else{
                    showAlert()
            }
        }else{
            
            if(!email.isEmpty && !password.isEmpty)||(self.progress.isFinished == true){
                self.createNewLine()
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if error == nil {
                                self.dismiss(animated: true, completion: nil)
                    }
                }
            }else{
                    showAlert()
            }
        }
        return true
       
    }
}

