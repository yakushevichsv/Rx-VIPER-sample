//
//  GoogleImageAPI.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/16/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import Foundation
import Moya

/*
 https://www.googleapis.com/customsearch/v1?q=Donald&searchType=image&key=AIzaSyAvlTX3u-JXpA8T3qY3_ybd5Vs-Lt6ZenI&cx=004564046329511145849:wp5tclag_sm
 
 https://www.googleapis.com/customsearch/v1?q={searchTerms}&num={count?}&start={startIndex?}&lr={language?}&safe={safe?}&cx={cx?}&cref={cref?}&sort={sort?}&filter={filter?}&gl={gl?}&cr={cr?}&googlehost={googleHost?}&c2coff={disableCnTwTranslation?}&hq={hq?}&hl={hl?}&siteSearch={siteSearch?}&siteSearchFilter={siteSearchFilter?}&exactTerms={exactTerms?}&excludeTerms={excludeTerms?}&linkSite={linkSite?}&orTerms={orTerms?}&relatedSite={relatedSite?}&dateRestrict={dateRestrict?}&lowRange={lowRange?}&highRange={highRange?}&searchType={searchType}&fileType={fileType?}&rights={rights?}&imgSize={imgSize?}&imgType={imgType?}&imgColorType={imgColorType?}&imgDominantColor={imgDominantColor?}&alt=json"
 }
 */

//MARK: - GoogleImageAPI
enum GoogleImageAPI {
    case image(query: String, startIndex: Int, count: Int)
}

extension GoogleImageAPI: TargetType {
    private struct Constants{
        static let queryKey = "q"
        static let startKey = "start"
        static let numKey = "num"
        static let key = "key"
        static let keyValue = "AIzaSyAvlTX3u-JXpA8T3qY3_ybd5Vs-Lt6ZenI"
        static let cx = "cx"
        static let cxValue = "004564046329511145849:wp5tclag_sm"
        static let searchType = "searchType"
        static let image = "image"
    }
    
    var baseURL: URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.googleapis.com"
        
        return try! urlComponents.asURL()
    }
    
    var path: String {
        return "/customsearch/v1"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String : Any]? {
        var params: [String: Any] = [Constants.key: Constants.keyValue,
                                     Constants.cx: Constants.cxValue,
                                     Constants.searchType: Constants.image]
        switch self {
        case .image(let query,let startIndex, let  count):
            assert(startIndex > 0) //can't be zero
            params[Constants.queryKey] = query
            params[Constants.startKey] = startIndex
            params[Constants.numKey] = count
            break
        }
        return params
    }
    
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        let sampleStr = "{\"kind\": \"customsearch#search\","
            + "\"url\": {\"type\": \"application/json\","
            + " \"template\": \"https://www.googleapis.com/customsearch/v1?q={searchTerms}"
            + "&num={count?}&start={startIndex?}&lr={language?}&safe={safe?}&cx={cx?}&cref={cref?}"
            + "&sort={sort?}&filter={filter?}&gl={gl?}&cr={cr?}&googlehost={googleHost?}"
            + "&c2coff={disableCnTwTranslation?}&hq={hq?}&hl={hl?}&siteSearch={siteSearch?}"
            + "&siteSearchFilter={siteSearchFilter?}&exactTerms={exactTerms?}"
            + "&excludeTerms={excludeTerms?}&linkSite={linkSite?}&orTerms={orTerms?}"
            + "&relatedSite={relatedSite?}&dateRestrict={dateRestrict?}&lowRange={lowRange?}"
            + "&highRange={highRange?}&searchType={searchType}&fileType={fileType?}"
            + "&rights={rights?}&imgSize={imgSize?}&imgType={imgType?}&imgColorType={imgColorType?}&imgDominantColor={imgDominantColor?}&alt=json\" },"
            + "\"queries\": { \"request\": [{\"title\": \"Google Custom Search - Donald\","
            + "\"totalResults\": \"677000000\", "
            + "\"searchTerms\": \"Donald\", "
            + "\"count\": 10, "
            + "\"startIndex\": 1,"
            + "\"inputEncoding\": \"utf8\", "
            + "\"outputEncoding\": \"utf8\", "
            + "\"safe\": \"off\","
            + "\"cx\": \"\(Constants.cxValue)\","
            + "\"searchType\": \"image\""
            + "}"
            + " ],"
            + "\"nextPage\": [ "
            + "{ "
            + "\"title\": \"Google Custom Search - Donald\", "
            + "\"totalResults\": \"677000000\", "
            + "\"searchTerms\": \"Donald\", "
            + "\"count\": 10, "
            + "\"startIndex\": 11, "
            + "\"inputEncoding\": \"utf8\", "
            + "\"outputEncoding\": \"utf8\", "
            + "\"safe\": \"off\", "
            + "\"cx\": \"\(Constants.cxValue)\", "
            + "\"searchType\": \"image\" "
            + "} "
            + "] "
            + "}, "
            + " \"context\": { "
            + "\"title\": \"Tut.by\" "
            + "}, "
            + "\"searchInformation\": { "
            + "\"searchTime\": 0.448521,"
            + "\"formattedSearchTime\": \"0.45\","
            + "\"totalResults\": \"677000000\","
            + "\"formattedTotalResults\": \"677,000,000\" "
            + "},"
            + "\"items\": ["
            + "{ "
            + "\"kind\": \"customsearch#result\","
            + "\"title\": \"Donald J. Trump (@realDonaldTrump) | Twitter\", "
            + "\"htmlTitle\": \"\u{003cb}\u{003e}Donald\u{003c}/b\u{003e} J. Trump (@realDonaldTrump) | Twitter\", "
            + "\"link\": \"https://pbs.twimg.com/profile_images/1980294624/DJT_Headshot_V2_400x400.jpg\", "
            + "\"displayLink\": \"twitter.com\", "
            + "\"snippet\": \"Donald J. Trump\", "
            + "\"htmlSnippet\": \"\u{003cb}\u{003e}Donald\u{003c}/b\u{003e} J. Trump\", "
            + "\"mime\": \"image/jpeg\", "
            + "\"image\": { "
            + "\"contextLink\": \"https://twitter.com/realdonaldtrump\", "
            + "\"height\": 400, "
            + "\"width\": 400, "
            + "\"byteSize\": 32081, "
            + "\"thumbnailLink\": \"https://encrypted-tbn0.gstatic.com/images? "
            + "q=tbn:ANd9GcQWSH0trCZ1J7M8IU0B1lGrQ0cZ9BLjcYGkTV6UKBP3Lt5Bej10iwFsKg\", "
            + "\"thumbnailHeight\": 124,"
            + "   \"thumbnailWidth\": 124 "
            + "  }"
            + " }"
            + "}]}"
        return sampleStr.utf8Data
    }
    
}
