//
//  ViewController.swift
//  ios_ws
//
//  Created by Hao Yu She on 2017/11/6.
//  Copyright © 2017年 Hao Yu She. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "loginToGameBoardSeg"){
            
            let nav = segue.destination as! UINavigationController
            
            let vc = nav.topViewController as! GameBoardController
            
            vc.setNavTitle(newUserName: userNameTF.text!)
        }
    }
}

