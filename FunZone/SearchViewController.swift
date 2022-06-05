//
//  SearchViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit
import WebKit

class SearchViewController: UIViewController{
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var customView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.isHidden = true
    }
    
    @IBAction func startSearching(_ sender: Any) {
        startButton.isHidden = true
        searchLabel.isHidden = true
        setupWebView()
    }
    
    func setupWebView(){
        customView.isHidden = false
        let newURL = URL(string : "https://www.google.com/")
        let webKitView = WKWebView(frame: customView.bounds)
        webKitView.load(URLRequest(url: newURL!))
        customView.addSubview(webKitView)
    }
    
    /*
    func openInNewScreen(){
        let storyObject = UIStoryboard(name: "Main", bundle: nil)
        let searchStartedScreen = storyObject.instantiateViewController(withIdentifier: "SearchStart") as! SearchStartViewController
                self.navigationController?.pushViewController(searchStartedScreen, animated: true)
    }
    */
}
