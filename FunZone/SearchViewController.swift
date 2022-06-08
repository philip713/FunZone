//
//  SearchViewController.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-01.
//

import UIKit
import WebKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchCustomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let webKitView = WKWebView()
        let newURL = URL(string: "https://www.google.com")!
        webKitView.load(URLRequest(url: newURL))
        view = webKitView
            
    }
    

}
