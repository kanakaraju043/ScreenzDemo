//
//  ViewController.swift
//  ScreenzDemoApp
//
//  Created by kanakaraju on 13/06/19.
//  Copyright © 2019 Administrator. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func LoadScreenz(_ sender: Any) {
        
        let button = sender as! UIButton
        print("pid is \(button.titleLabel?.text ?? "") and pageId is \(button.tag)")
        
        if let screenzViewController:ScreenzViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScreenzViewController") as? ScreenzViewController{
            
            screenzViewController.screenzPid = button.titleLabel?.text ?? ""
            screenzViewController.screenzPageId = "\(button.tag)"
           
            self.navigationController?.pushViewController(screenzViewController, animated: true)
        }
        
        
    }
    
   
}

