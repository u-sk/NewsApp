//
//  BaseViewController.swift
//  NewsXML
//
//  Created by 板垣有祐 on 2019/09/21.
//  Copyright © 2019 Yusuke Itagaki. All rights reserved.
//

import UIKit
import SegementSlide

class BaseViewController: SegementSlideViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // GitHubのUsage通り
        reloadData()
        // タブの初期位置
        scrollToSlide(at: 0, animated: false)
        
    }
    

    override var headerView: UIView? {
        let headerView = UIImageView()
        //
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleToFill
        headerView.image = UIImage(named: "header1")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let headerHeight: CGFloat
        if #available(iOS 11.0, *) {
            headerHeight = view.bounds.height/4 + view.safeAreaInsets.top
        } else {
            headerHeight = view.bounds.height/4 + topLayoutGuide.length
        }
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        return headerView
    }
    
    // タイトルを準備(6つ分)
    override var titlesInSwitcher: [String] {
        return ["Yahoo!", "ギズモード", "ライフハッカー", "ゴリミー", "TechCrunch", "日経"]
    }
    
    // コントローラー(6つ分)
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        switch index {
        case 0:
            return Page1ViewController()
        case 1:
            return Page2ViewController()
        case 2:
            return Page3ViewController()
//        case 3:
//            return Page4ViewController()
        case 3:
            return Page5ViewController()
        case 4:
            return Page6ViewController()
        case 5:
            return Page7ViewController()
        default : return Page1ViewController()

        }

    }
    

}
