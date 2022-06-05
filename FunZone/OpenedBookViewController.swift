//
//  OpenedBookViewController.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//

import UIKit
import PDFKit

class OpenedBookViewController: UIViewController {
    @IBOutlet weak var bookView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    var pdfname = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = pdfname
        viewPdf(viewIn : bookView, filename: pdfname)
        // Do any additional setup after loading the view.
    }
    
    func viewPdf(viewIn : UIView, filename : String){
        let pdfView = PDFView(frame: viewIn.bounds)
        viewIn.addSubview(pdfView)
        pdfView.autoScales = true
        let filePath = Bundle.main.url(forResource: filename, withExtension: "pdf")
        pdfView.document = PDFDocument(url : filePath!)
    }
}
