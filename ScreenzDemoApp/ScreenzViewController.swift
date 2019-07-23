//
//  ScreenzViewController.swift
//  ScreenzDemoApp
//
//  Created by kanakaraju on 13/06/19.
//  Copyright © 2019 Administrator. All rights reserved.
//

import UIKit
import ScreenzSDK

class ScreenzViewController: UIViewController ,ScreenzSDKManagerDelegate{
   
    let manager = ScreenzSDKManager.sharedInstance()
    var screenzPid:String = ""
    var screenzPageId:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        manager?.loadConfiguration(fromJSONFile: "config")
        manager?.setDelegate(self)
        
        self.loadScreenzWithPidAndJWTToken(screenzCurrentPid: self.screenzPid, pageId: self.screenzPageId)
    }
    

    func loadScreenzWithPidAndJWTToken(screenzCurrentPid:String , pageId:String) {
        
        manager?.changeCurrentPID(Int32(screenzCurrentPid) ?? 0)
        manager?.setLaunchPageID(pageId)
        
        let dict = ["provider":"jio","token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJwaG9uZU5vIjoidS03Y2Q5MWJhZS00ZTEyLTQzNjEtOGU2Ni1kYmU3ZTY0MDJmZDIiLCJuYW1lIjoiR3VyYXYiLCJpYXQiOjE1NjEwNDEzOTEsImV4cCI6MTU2MTY0NjE5MX0.70trKqQNWJIYWBGNUB-mv1V3yBRlhjq0sB8YqyPAyFI"]
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        guard let jsondata = jsonData else{
            return
        }
        let jsonString = String(data: jsondata, encoding: .utf8)
        print(jsonString ?? "")
        manager?.setExtraData(jsonString)
        loadScreenzWebView()
    }
    
    // MARK:- loadScreenzWebView setup
    
    func loadScreenzWebView(){
        manager?.load(in: self.view, viewController: self)
    }
    
    func screenzSDKManagerDelegate_dataReceived(_ data: String!) {
        
        print("RECEIVED data from Screenz: \(data ?? "")")
        
        if let data = data{
            if  data.elementsEqual("sdk-exit-new"){
                manager?.clearView()
                self.navigateToDashBoard()
            }
        }
    }
    
    func navigateToDashBoard(){
        self.navigationController?.popViewController(animated: true);
    }

}
