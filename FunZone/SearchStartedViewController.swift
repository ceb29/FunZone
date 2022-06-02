//
//  SearchStartedViewController.swift
//  FunZone
//
//  Created by admin on 6/2/22.
//

import UIKit
import WebKit

class SearchStartedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var webKitView = WKWebView()
        let newURL = URL(string : "https://www.google.com/")
        webKitView.load(URLRequest(url: newURL!))
        view = webKitView
        // Do any additional setup after loading the view.
    }
}
