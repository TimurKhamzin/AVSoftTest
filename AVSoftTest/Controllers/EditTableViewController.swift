//
//  EditViewController.swift
//  AVSoftTest
//
//  Created by Timur Khamzin on 06.03.2020.
//  Copyright © 2020 Timur Khamzin. All rights reserved.
//

import UIKit
import RealmSwift

class EditTableViewController: UITableViewController {
    
    var humanTableViewCell = HumanTableViewCell()
    var storageManager = StorageManager()
    let person = realm.objects(Person.self)
    var imageArray = ["Image","Image2","Image3","Image4","Image5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsForTableView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addpersonAction(_ sender: Any) {
        self.present(createAlertForPerson(), animated: true)
    }
    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func settingsForTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HumanTableViewCell", bundle: nil), forCellReuseIdentifier: HumanTableViewCell.reuseID)
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
    }
    

    //Отображение ячеек с проверкой , если ячейки равны 0 , то вызывается алерт , что таблица пустая и надо добавить человека
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if person.count == 0 {
                  self.present(createEmptyAlert(), animated: true)
              }
        return person.count
    }
    
    //Создание Алерта , если таблица с людьми пустая
    func createEmptyAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Предупреждение", message: "В данный момент в таблице нету пользователей, добавьте людей с помощью кнопки ", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Добавить", style: .default, handler: addpersonAction)
        let cancelAction = UIAlertAction(title: "Отменить", style: .destructive, handler: nil) //созадние кнопки отмены
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        return alert
        
    }
    
    
    func createAlertForPerson() -> UIAlertController {
        let alert = UIAlertController(title: "Введите данные о человеке", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.textFields![0].placeholder = "Имя"
        alert.addTextField(configurationHandler: nil)
        alert.textFields![1].placeholder = "Пол"
        alert.addTextField(configurationHandler: nil)
        alert.textFields![2].placeholder = "Возвраст"
        let cancelAction = UIAlertAction(title: "Отменить", style: .destructive, handler: nil) //созадние кнопки отмены
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            let currentPerson = Person()
            
            if self.person.count != 0 {
                currentPerson.id = self.person.last!.id + 1
            } else {
                currentPerson.id = 1
            }
            
            currentPerson.name = alert.textFields![0].text!
            currentPerson.sex = alert.textFields![1].text!
            currentPerson.age = Int(alert.textFields![2].text!)!
            
            
            self.storageManager.addToDB(object: currentPerson)
            
            self.tableView.reloadData()
            
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        return alert
    }
    
    //Отображение уже добавленных данных о человеке
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: HumanTableViewCell.reuseID, for: indexPath) as! HumanTableViewCell
          cell.nameLabel?.text = self.person[indexPath.row].name
          cell.ageLabel?.text = String(self.person[indexPath.row].age)
          cell.genderLabel?.text = self.person[indexPath.row].sex
          cell.avatarView?.image = UIImage(named: imageArray[indexPath.row])
          
          return cell
      }
      
      override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          
          
          return 145
      }
      
      //Настрйока отображения заднего фона TableView при тапе
      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          performSegue(withIdentifier: "showProfile", sender: nil)
          tableView.deselectRow(at: indexPath, animated: true)

      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProfile"{
            let indexPath = tableView.indexPathForSelectedRow
            let destVC = segue.destination as! ShowViewController
            destVC.person = person[indexPath?.row ?? 0]
            
            print(destVC.person)

            
            destVC.navigationItem.title = person[indexPath!.row].name
        }
    }
    
    //Alert For Update
    
    func updateAlertForPersons(persons: Person) -> UIAlertController {
        let alert = UIAlertController(title: "Введите новые данные", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.textFields![0].text = persons.name
        
        alert.addTextField(configurationHandler: nil)
        alert.textFields![1].text = persons.sex
        
        alert.addTextField(configurationHandler: nil)
        alert.textFields![2].text = String(persons.age)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            try! realm.write {
                persons.name = alert.textFields![0].text!
                persons.sex = alert.textFields![1].text!
                persons.age = Int(alert.textFields![2].text!) ?? 0
            }
            
            self.tableView.reloadData()
        }
        
        alert.addAction(okAction)
        
        return alert
    }
      
      //Метод удаления ячейки с базы данных и таблицы
      
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
          
          let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") {(_,_, completion) in
              
              self.storageManager.removeFromDB(object: self.person[indexPath.row])
              self.tableView.deleteRows(at: [indexPath], with: .fade)
              self.tableView.reloadData()
              completion(true)
          }
          
          let updateAction = UIContextualAction(style: .normal, title: "Изменить") {(_,_, completion) in
              
              self.present(self.updateAlertForPersons(persons: self.person[indexPath.row]), animated: true, completion: nil)
              completion(true)
              
          }
          updateAction.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
          
          
          return UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
          
      }
      
      
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
          let updateAction = UIContextualAction(style: .normal, title: "Изменить") {(_,_, completion) in
              
              self.present(self.updateAlertForPersons(persons: self.person[indexPath.row]), animated: true, completion: nil)
              completion(true)
              
          }
          updateAction.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
          
          return UISwipeActionsConfiguration(actions: [updateAction])
      }
    

}

