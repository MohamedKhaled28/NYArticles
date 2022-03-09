//
//  ViewController.swift
//  NY Articles
//
//  Created by Mohamed Khaled on 3/8/22.
//  Copyright © 2022 Mohamed Khaled. All rights reserved.
//

import UIKit

class ArticlesMasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var articleViewModels = [ArticleViewModel]()
    let articleCellId = "ArticleCellId"
    
    let detailsSegueId = "showArticleDetail"
    var selectedArticle: ArticleViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getArticles()
    }

    func setupTableView() {
        let articleNib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        self.tableView.register(articleNib, forCellReuseIdentifier: articleCellId)
    }
    
    func getArticles() {
        showLoading()
        ApiManager.getArticles(period: .week, success: { articles in
            self.articleViewModels = articles.map{ArticleViewModel(article: $0)}
            self.tableView.reloadData()
            self.hideLoading()
        }, failure: { errorMessage in
            self.hideLoading()
            self.showAlert(title: "Error", message: errorMessage)
        })
    }
    
    // MARK: - Table view data source
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleViewModels.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleCell = tableView.dequeueReusableCell(withIdentifier: articleCellId, for: indexPath) as! ArticleTableViewCell
        articleCell.articleViewModel = articleViewModels[indexPath.row]
        return articleCell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = articleViewModels[indexPath.row]
        performSegue(withIdentifier: detailsSegueId, sender: nil)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailsSegueId {
            let detailsVC = segue.destination as! ArticleDetailsViewController
            detailsVC.articleViewModel = selectedArticle
        }
    }
    

}

