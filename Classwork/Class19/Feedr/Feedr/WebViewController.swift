//
//  WebViewController.swift
//  Feedr
//
//  Created by Tedi Konda on 3/2/15.
//  Copyright (c) 2015 Tedi Konda. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    var request: NSURLRequest?
    var passedTitle: NSString?
    
    override func viewDidLoad() {
        if let myTitle = self.passedTitle {
            self.title = myTitle
        }
        if let request = self.request {
            self.webView.loadRequest(request)
        }
    }

}
