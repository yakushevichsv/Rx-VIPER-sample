//
//  Extensions.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/12/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import Foundation

let syEmptyString = ""

//MARK: - String
extension String {
    static var empty: String {
        return syEmptyString
    }
    
    var urlEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) ?? String.empty
    }
    
    var utf8Data: Data {
        return self.data(using: .utf8) ?? Data()
    }
}

//MARK: - HerbsAndHealthProblem
extension HerbsAndHealthProblem: Hashable {
     public static func ==(lhs: HerbsAndHealthProblem, rhs: HerbsAndHealthProblem) -> Bool {
        return lhs.objectId == rhs.objectId &&
                lhs.herbId == rhs.herbId &&
                lhs.herbName == rhs.herbName &&
                lhs.healthProblemName == rhs.healthProblemName
                
    }

    var hashValue: Int {
        return (objectId + "\(herbId)").hashValue
    }
}

extension Date {
    func shortDescription() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
}
