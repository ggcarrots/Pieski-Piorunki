//
//  NewsContent.swift
//  carrots
//
//  Created by Mateusz Orzoł on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


struct NewsCategoryContent {
    
    let category: NewsCategory
    var newsContent: [NewsContent] = []
}

struct NewsContent {
    
    let isFromCloud: Bool
    let time: Int
    let newsType: NewsType
    let title: String
    var finished: Bool = false
    let image: UIImage?
    let URL: URL
    var articleInfo: Info? = nil
}

enum NewsType {
    
    case movie
    case twitter
    case article
    
    var image: UIImage {
        switch self {
        case .movie: return #imageLiteral(resourceName: "play")
        case .twitter: return #imageLiteral(resourceName: "twitter")
        case .article: return #imageLiteral(resourceName: "task")
        }
    }
}
