//
//  ViewController.swift
//  AVSoftTest
//
//  Created by Timur Khamzin on 04.03.2020.
//  Copyright © 2020 Timur Khamzin. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

protocol ViewControllerDelegate {
    func toggleMenu()
}

class ViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    
    var delegate: ViewControllerDelegate?  //Экземпляр делегата для общения с MainContainerVC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        menuButton.alpha = 0.7
        menuButton.layer.cornerRadius = 20
        menuButton.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func exitAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }catch{
            print("Error")
        }
    }
    
    
    @IBAction func menuAction(_ sender: Any) {
        delegate?.toggleMenu()
    }
}
