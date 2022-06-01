//
//  SearchViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit
import WebKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startClicked(_ sender: Any) {
        var webKitView = WKWebView()
        let newURL = URL(string : "https://www.google.com/")
        webKitView.load(URLRequest(url: newURL!))
        view = webKitView
    }
}
