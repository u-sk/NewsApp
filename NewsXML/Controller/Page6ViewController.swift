//
//  Page6ViewController.swift
//  NewsXML
//
//  Created by 板垣有祐 on 2019/09/21.
//  Copyright © 2019 Yusuke Itagaki. All rights reserved.
//

import UIKit
import SegementSlide

class Page6ViewController: UITableViewController,SegementSlideContentScrollViewDelegate, XMLParserDelegate {
    
    // XMLParserのインスタンスを作成する
    var parser: XMLParser?
    
    // RSSのパース中の現在の要素名
    var currentElementName: String!
    
    // NewsItems型の配列
    var newsItems = [NewsItems]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .clear
        
        // 画像をtableの下に置く
        let image = UIImage(named: "5")
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width , height: self.tableView.frame.size.height)
        imageView.image = image
        self.tableView.backgroundView = imageView
        
        // WebサイトのURLを指定
        let urlString = "https://jp.techcrunch.com/feed/"
        // urlString(文字列)をURL型に変更
        let url: URL = URL(string: urlString)!
        // XMLParserのイニシャライザ
        if let parser = XMLParser(contentsOf: url) {
            // デリゲートに指定
            parser.delegate = self
            // データの解析
            parser.parse()
        }
        
        
    }
    
    @objc var scrollView: UIScrollView {
        return tableView
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/5
    }
    
    // パースした時に、必要なデータだけを取り出す処理をするメソッド
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElementName = nil
        if elementName == "item"{
            self.newsItems.append(NewsItems())
        } else {
            currentElementName = elementName
        }
    }
    
    // 必要な内容が見つかった場合にこのメソッドが呼ばれ、このメソッドの中に文字列などを取り出す
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.newsItems.count > 0 {
            let lastItem = self.newsItems[self.newsItems.count - 1]
            
            switch self.currentElementName {
            case "title":
                lastItem.title = string
            case "link":
                lastItem.url = string
            case "pubdate":
                lastItem.pubDate = string
            default : break
                
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentElementName = nil
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // WebViewcontrollerにurlを渡して表示
        let webViewController = WebViewController()
        webViewController.modalTransitionStyle = .crossDissolve
        let newsItem = newsItems[indexPath.row]
        UserDefaults.standard.set(newsItem.url, forKey: "url")
        present(webViewController, animated: true, completion: nil)
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = .clear
        let newsItems = self.newsItems[indexPath.row]
        
        cell.textLabel?.text = newsItems.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 3
        // サブタイトル
        cell.detailTextLabel?.text = newsItems.url
        cell.detailTextLabel?.textColor = .white
        
        return cell
    }
    
    
    
    
}

