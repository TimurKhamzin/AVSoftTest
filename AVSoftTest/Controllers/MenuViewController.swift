//
//  MenuViewController.swift
//  AVSoftTest
//
//  Created by Timur Khamzin on 06.03.2020.
//  Copyright © 2020 Timur Khamzin. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate {
    func toggleSettings()
}

class MenuViewController: UIViewController {
    
    var delegate: MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editAction(_ sender: Any) {
        performSegue(withIdentifier: "EditTableViewController", sender: nil)
    }
    
    @IBAction func showAction(_ sender: Any) {
        performSegue(withIdentifier: "ShowViewController", sender: nil)
    }
    
    @IBAction func aboutAction(_ sender: Any) {
        performSegue(withIdentifier: "AboutViewController", sender: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
