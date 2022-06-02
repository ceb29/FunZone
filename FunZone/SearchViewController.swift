//
//  SearchViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func startClicked(_ sender: Any) {
        let storyObject = UIStoryboard(name: "Main", bundle: nil)
        let searchStartedScreen = storyObject.instantiateViewController(withIdentifier: "SearchStart") as! SearchStartedViewController
        self.navigationController?.pushViewController(searchStartedScreen, animated: true)
    }
}
