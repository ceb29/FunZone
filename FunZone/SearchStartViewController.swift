//
//  SearchStartViewController.swift
//  FunZone
//
//  Created by admin on 6/3/22.
//

import UIKit
import WebKit

class SearchStartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    func setupWebView(){
        let newURL = URL(string : "https://www.google.com/")
        let webKitView = WKWebView()
        webKitView.load(URLRequest(url: newURL!))
        self.view = webKitView
    }
}
