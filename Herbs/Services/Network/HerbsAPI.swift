//
//  HerbsAPI.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/12/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import Foundation
import Moya


enum HerbsAPI {
    case basicQuery
    case retrieve(HerbsAndHealthProblem.ObjectIdType)
    
    static let endpointClosure = { (target: HerbsAPI) -> Endpoint<HerbsAPI> in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(target)
        
        let extraDic = ["X-Parse-Application-Id": "xVNxsERVuokEyT96u1MBwDgok2nprSnt4WkV24WU",
                        "X-Parse-REST-API-Key": "VlP02U1K9VAxmzEZMCSt3Ki99Y5kCVORArgTc3hw"]
        
        return defaultEndpoint.adding(newHttpHeaderFields: extraDic)
    }
}

//MARK: - TargetType
extension HerbsAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://parseapi.back4app.com")!
    }
    
    var path: String {
        switch self {
        case .retrieve(let objectID):
            return "/classes/HerbsAndHealthProblems/" + objectID.description
        case .basicQuery:
            return "/classes/HerbsAndHealthProblems/"
        }
        //return String.empty
    }
    
    var method: Moya.Method  {
        return .get
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var sampleData: Data {
        switch self {
        case .basicQuery:
            return "{\"results\":[{\"objectId\":\"6kMsIptcj1\",\"HerbName\":\"Betaine Anhydrous\",\"HealthProblemName\":\"depression\",\"HerbId\":130,\"createdAt\":\"2016-08-30T05:51:10.683Z\",\"updatedAt\":\"2016-08-30T05:51:10.683Z\"}]}".utf8Data
        case .retrieve(let objectID):
            return "{\"objectId\":\"\(objectID)\",\"HerbName\":\"Betaine Anhydrous\",\"HealthProblemName\":\"depression\",\"HerbId\":130,\"createdAt\":\"2016-08-30T05:51:10.683Z\",\"updatedAt\":\"2016-08-30T05:51:10.683Z\"}".utf8Data
        }
    }
    
    var task: Task {
        return .request
    }
    
}
