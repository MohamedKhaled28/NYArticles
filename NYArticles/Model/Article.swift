//
//  Article.swift
//  NY Articles
//
//  Created by Mohamed Khaled on 3/8/22.
//  Copyright © 2022 Mohamed Khaled. All rights reserved.
//

struct Articles: Decodable {
    var results: [Article]
}

struct Article: Decodable {
    var title: String
    var byline: String
    var abstract: String
    var publishedDate: String
    var media: [ArticleMedia]
}

struct ArticleMedia: Decodable {
    var mediaMetadata: [ArticleMediaMetaData]

    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
    
    init(mediaMetaData: [ArticleMediaMetaData]) {
        self.mediaMetadata = mediaMetaData
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mediaMetadata = try container.decode([ArticleMediaMetaData].self, forKey: .mediaMetadata)
    }
}

struct ArticleMediaMetaData: Decodable {
    var url: String
    var format: String
}
