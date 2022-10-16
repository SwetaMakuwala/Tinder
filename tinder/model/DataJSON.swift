//
//  Data.swift
//  tinder
//
//  Created by sweta makuwala on 09/12/21.
//

import Foundation
struct  DataJSON: Decodable  {
    let results: [Item]
    let info : Info
}
struct Item: Decodable {
    let gender : String
    let name : Name
    let location: Location
    let phone: String
    let picture: Picture
    let dob: DOB
}
struct Name: Decodable{
    let title : String
    let first: String
    let last: String
}
struct Location: Decodable{
    let city: String
    let state: String
    let country: String
}
struct DOB: Decodable{
    let date: String
    let age: Int
}
struct Picture : Decodable{
    let large : String
    let medium : String
}
struct Info: Decodable{
    let page: Int
    let version : String
}

