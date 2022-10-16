//
//  Person+CoreDataProperties.swift
//  tinder
//
//  Created by sweta makuwala on 22/12/21.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var picture: String?
    @NSManaged public var dob: String?
    @NSManaged public var address: String?

}

extension Person : Identifiable {

}
