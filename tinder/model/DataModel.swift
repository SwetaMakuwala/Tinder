//
//  dataModel.swift
//  tinder
//
//  Created by sweta makuwala on 11/12/21.
//

import Foundation

class DataModel{
    var name: [String]
    var address : [String]
    var dob :  [String]
    var picture : [String]
    init (name:  [String] , address:  [String], dob:  [String], picture:  [String]){
        self.name = name
        self.address = address
        self.dob = dob
        self.picture = picture
    }
    
}
