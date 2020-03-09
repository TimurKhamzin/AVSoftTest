//
//  AboutViewController.swift
//  AVSoftTest
//
//  Created by Timur Khamzin on 06.03.2020.
//  Copyright © 2020 Timur Khamzin. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    var tappedButtonSet: Bool = true {
        willSet{
            if newValue{
               
                tappedOutlet.setTitle("Открыть репозиторий", for: .normal)
                linkButton.isHidden = true
            } else {
                 tappedOutlet.setTitle("Cкрыть репозиторий", for: .normal)
                 linkButton.isHidden = false
            }
        }
    }
    
    @IBOutlet weak var tappedOutlet: UIButton!
    @IBOutlet weak var linkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        linkButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tappedButton(_ sender: Any) {
        tappedButtonSet = !tappedButtonSet
    }
    
    @IBAction func linkButtonAction(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "https://github.com/TimurKhamzin/AVSoftTest")! as URL)
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
