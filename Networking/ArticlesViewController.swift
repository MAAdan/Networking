//
//  ArticlesViewController.swift
//  Networking
//
//  Created by Miguel Angel Adan Roman on 23/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit
import Alamofire

class ArticlesViewController: UITableViewController {
    
    var articleList: ArticleList?
    
    deinit {
        print("ArticlesViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if let url = URL(string: "https://www.avantiic.net/json/index.json") {
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
            
            Alamofire.request(request).validate(statusCode: 200..<300).responseData { (response) in
                switch response.result {
                case .success(let data):
                    let dataMapper = ArticleListDataMapper()
                    let parser = ParseData<ArticleList>(dataMapper: dataMapper)
                    self.articleList = parser.parse(data: data)
                    
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList?.articles.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        
        if let article = articleList?.articles[indexPath.row] {
            cell.title.text = article.title
            
            if let urlImage = article.image, let url = URL(string: urlImage) {
                cell.customImageUrl = urlImage
                
                if let image = ImageDownloadManager.default.imageFor(url: url) {
                    cell.customImageView.image = image
                } else {
                    cell.customImageUrl = urlImage
                    ImageDownloadManager.default.downloadImageWith(url: url, completionHandler: { (image) in
                        if cell.customImageUrl == url.absoluteString {
                            cell.customImageView.image = image
                        }
                    })
                }
            }
        }
        
        return cell
    }
}
