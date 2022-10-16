//
//  ViewController.swift
//  tinder
//
//  Created by sweta makuwala on 08/12/21.
//

import UIKit

class ViewController:UIViewController{
var dataManager = DataManager()
   var name: String = " "

    override func viewDidLoad() {
        super.viewDidLoad()
       // dataManager.delegate = self
        dataManager.fetchRequest()
    }
    
  //  func passedInfo(dataModel: DataModel){ }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as! TableViewController
        VC.nameArray = dataManager.nameArray
        VC.addressArray = dataManager.addressArray
        VC.dobArray = dataManager.dobArray
        VC.pictureArray = dataManager.pictureArray
    }

}

