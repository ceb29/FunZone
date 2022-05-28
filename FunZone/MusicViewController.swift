//
//  MusicViewController.swift
//  FunZone
//
//  Created by admin on 5/26/22.
//

import UIKit

class MusicViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var dataText = ["1", "2", "3", "4", "5"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MusicTableViewCell
        myCell.musicLabel.text = dataText[indexPath.row]
        return myCell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
