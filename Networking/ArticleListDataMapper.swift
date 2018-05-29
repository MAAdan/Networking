//
//  ArticleListDataMapper.swift
//  Networking
//
//  Created by Miguel Angel Adan Roman on 26/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation

class ArticleListDataMapper: MapperProtocol {
    
    func map(dictionary: Any) -> MappedObject {
        var articles: [Article]?
        
        if let dictionary = dictionary as? [String: AnyObject], let contents = dictionary["cts"] as? [[String: AnyObject]] {
            
            articles = contents.flatMap({ (articleDict) -> Article? in
                if let title = articleDict["titulo"] as? String, let multimedia = articleDict["multimedia"] as? [[String: Any]], let first = multimedia.first, let image = first["url"] as? String {
                    
                    return Article(title: title, image: image)
                }
                
                return nil
            })
        }
        
        guard let articlesNotNil = articles else {
            return ArticleList(articles: [])
        }
        
        return ArticleList(articles: articlesNotNil)
    }
}
