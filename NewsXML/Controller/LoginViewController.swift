//
//  LoginViewController.swift
//  NewsXML
//
//  Created by 板垣有祐 on 2019/09/21.
//  Copyright © 2019 Yusuke Itagaki. All rights reserved.
//

import UIKit
import AVFoundation

class LoginViewController: UIViewController {

    // プレイヤーインスタンスを生成
    var player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 動画ファイルを指定
       let path = Bundle.main.path(forResource: "start", ofType: "mov")
       // プレイヤーに動画ファイル名を指定
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        
        // AVPlayer用のレイヤー(layer)を生成
        let playerLayer = AVPlayerLayer(player: player)
        // レイヤーのフレームを決める(画面いっぱい)
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        // playerLayerの設定
        playerLayer.videoGravity = .resizeAspectFill
        // 無限ループのために設定(終わった後のアクションは下に記載)
        playerLayer.repeatCount = 0
        playerLayer.zPosition = -1
        // レイヤーをビューの一番下に配置
        view.layer.insertSublayer(playerLayer, at: 0)
        
        // 終了まで行ったら、また一番は始めに戻す
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { (_) in
            // playerのzero(開始位置)に戻る
            self.player.seek(to: .zero)
            self.player.play()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }

    @IBAction func loginButton(_ sender: Any) {
        player.pause()
    }
    

}
