//
//  IntroViewController.swift
//  NewsXML
//
//  Created by 板垣有祐 on 2019/09/21.
//  Copyright © 2019 Yusuke Itagaki. All rights reserved.
//

import UIKit
import Lottie

class IntroViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var animationArray = ["1", "2", "3", "4", "5"]
    var animationStringArray = ["ニュース",
                             "だよ！",
                             "色々",
                             "見てください",
                             "ね！"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ページングが可能になる
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        setUpScroll()
        
        // Lottieを使用する
        for i in 0...4 {
            let animationView = AnimationView()
            let animation = Animation.named(animationArray[i])
            animationView.frame = CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()
            scrollView.addSubview(animationView)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }

    
    
    func setUpScroll() {
        // スクロールビューのコンテンツサイズ(稼働領域)を決める
        // ページングするので横幅はコンテンツの数(全ページ数)をかける
        scrollView.contentSize = CGSize(width: view.frame.size.width * 5 , height: scrollView.frame.size.height)
        
        // for文でラベルを設定する
        for i in 0...4 {
            // xはiが0の時は最初の画面、1の時は一つ右にずれる
            let scrollLabel = UILabel(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: view.frame.size.height/4, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            scrollLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
            scrollLabel.textAlignment = .center
            scrollLabel.text = animationStringArray[i]
            scrollLabel.numberOfLines = 0
            scrollView.addSubview(scrollLabel)
        }
    }

}
