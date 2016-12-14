//
//  HerbsAndHealthProblems.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/12/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import Foundation
import Mapper

//MARK: - HerbsAndHealthProblem
struct HerbsAndHealthProblem {
    typealias ObjectIdType = String
     let objectId: ObjectIdType
     let herbName: String
     let healthProblemName: String
     let herbId: Int
    let createdAt: Date?
    let updatedAt: Date?
    
    private static var s_formatter: DateFormatter! = nil
    
    static var formatter: DateFormatter! {
        if HerbsAndHealthProblem.s_formatter == nil {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            HerbsAndHealthProblem.s_formatter = formatter
        }
        return HerbsAndHealthProblem.s_formatter
    }
}

//MARK: - Mappable
extension HerbsAndHealthProblem: Mappable {
    
    init(map: Mapper) throws {
        objectId = try map.from("objectId")
        herbName = try map.from("HerbName")
        healthProblemName = try map.from("HealthProblemName")
        herbId = try map.from("HerbId")
        createdAt =  HerbsAndHealthProblem.formatter.date(from: try map.from("createdAt"))
        updatedAt = HerbsAndHealthProblem.formatter.date(from: try map.from("updatedAt"))
    }
}

//MARK: - HerbsAndHealthProblemWrapper
struct HerbsAndHealthProblemWrapper {
    let herb: HerbsAndHealthProblem
    let data: Data
}

