//
//  Drone+CoreDataProperties.swift
//  
//
//  Created by Monrada Juycharoen on 3/19/2561 BE.
//
//

import Foundation
import CoreData


extension Drone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Drone> {
        return NSFetchRequest<Drone>(entityName: "Drone")
    }

    @NSManaged public var id: String?

}
