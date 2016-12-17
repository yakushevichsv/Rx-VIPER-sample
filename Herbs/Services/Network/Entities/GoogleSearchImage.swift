//
//  GoogleSearchImage.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/17/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import Foundation
import Mapper

/*
 
 "kind": "customsearch#result",
 "title": "Donald J. Trump (@realDonaldTrump) | Twitter",
 "htmlTitle": "\u003cb\u003eDonald\u003c/b\u003e J. Trump (@realDonaldTrump) | Twitter",
 "link": "https://pbs.twimg.com/profile_images/1980294624/DJT_Headshot_V2_400x400.jpg",
 "displayLink": "twitter.com",
 "snippet": "Donald J. Trump",
 "htmlSnippet": "\u003cb\u003eDonald\u003c/b\u003e J. Trump",
 "mime": "image/jpeg",
 "image": {
 "contextLink": "https://twitter.com/realdonaldtrump",
 "height": 400,
 "width": 400,
 "byteSize": 32081,
 "thumbnailLink": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWSH0trCZ1J7M8IU0B1lGrQ0cZ9BLjcYGkTV6UKBP3Lt5Bej10iwFsKg",
 "thumbnailHeight": 124,
 "thumbnailWidth": 124
 
 
 
 */

//MARK: - GoogleSearchImage
struct GoogleSearchImage {
    let title: String
    let imageLink: URL
    let contentImage: GoogleSearchContentImage
    let displayLink: String
}

//MARK: - GoogleSearchImage Mapper's implementation
extension GoogleSearchImage: Mappable {
    init(map: Mapper) throws {
        title = try map.from("title")
        imageLink = try map.from("link")
        contentImage = try map.from("image")
        displayLink = try map.from("displayLink")
    }
}

//MARK: - GoogleSearchContentImage
struct GoogleSearchContentImage {
    let contextLink: URL
    let height: Int
    let width: Int
    let thumbLink: URL
    let thumbWidth: Int
    let thumbHeight: Int
}

//MARK: - GoogleSearchContentImage Mapper's implementation
extension GoogleSearchContentImage: Mappable {
    init(map: Mapper) throws {
        contextLink = try map.from("contextLink")
        height = try map.from("height")
        width = try map.from("width")
        thumbLink = try map.from("thumbnailLink")
        thumbHeight = try map.from("thumbnailHeight")
        thumbWidth = try map.from("thumbnailWidth")
    }
}
