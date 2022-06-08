//
//  PDFScreenViewController.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-02.
//

import UIKit
import PDFKit

class PDFScreenViewController: UIViewController {
    
    var pdfName : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var pdfView : PDFView? = nil
        pdfView = PDFView(frame: view.bounds)
        pdfView?.autoScales = true
        let filePath = Bundle.main.url(forResource: pdfName, withExtension: "pdf")
        pdfView?.document = PDFDocument(url: filePath!)
        view.addSubview(pdfView!)
        
    }
    

}
