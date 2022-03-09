//
//  MostPopularArticlesApi.swift
//  NY Articles
//
//  Created by Mohamed Khaled on 3/8/22.
//  Copyright © 2022 Mohamed Khaled. All rights reserved.
//

import Moya

enum MostPopularArticlesApi {

    case getPopularArticles(period: ArticlesPeriod)
}

enum ArticlesPeriod: Int {
    case day = 1
    case week = 7
    case month = 30
}

extension MostPopularArticlesApi: TargetType {
    
    var baseURL: URL {
        let urlString = Constants.SERVER_URL
        guard let url = URL(string: urlString) else {
            fatalError("base URL could not be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getPopularArticles(let period):
            return "\(Constants.MOST_POPULAR_API)\(Constants.API_VERSION)/viewed/\(period.rawValue).json"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return Task.requestParameters(
            parameters: ["api-key" : Constants.API_KEY],
            encoding: URLEncoding.default
        )
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
