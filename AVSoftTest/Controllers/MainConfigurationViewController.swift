//
//  MainConfigurationViewController.swift
//  AVSoftTest
//
//  Created by Timur Khamzin on 06.03.2020.
//  Copyright © 2020 Timur Khamzin. All rights reserved.
//

import UIKit

class MainConfigurationViewController: UIViewController,ViewControllerDelegate, MenuViewControllerDelegate {
    func toggleSettings() {
    }
    
    
    //Создание экземпляров контроллеров, добавляемых в контейнер
    var controller: UIViewController!
    var menuController: UIViewController!
    
    //Переменные, хранящие статус контроллеров - открыт или закрыт
    var isMove: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainVC()
        // Do any additional setup after loading the view.
    }
    
    //конфигурация главного контроллера
    func configureMainVC() {
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        mainVC.delegate = self
        controller = mainVC
        view.addSubview(controller.view)
        addChild(controller)
    }
    
    //конфигурация Меню-контроллера
    func configureMenuVC() {
        
        if menuController == nil {
            let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuVC") as! MenuViewController
            menuVC.delegate = self
            menuController = menuVC
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            print("MenuViewController has been added!")
            
        }
        
    }
    
    
    //настройка анимации отображения и скрытия меню-контроллера
    func showMenuVC(shouldMove: Bool) {
        
        if shouldMove {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.x = self.controller.view.frame.width * 0.7
            }) { (finished) in
                print("Animation is Completed!")
            }
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.x = 0
            }) { (finished) in
                print("Animation is Completed!")
            }
        }
    }
    
    //метод отображения меню-контроллера
    func toggleMenu() {
        configureMenuVC()
        isMove = !isMove
        showMenuVC(shouldMove: isMove)
    }
    
}
