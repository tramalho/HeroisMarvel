//
//  HeroViewController.swift
//  HeroisMarvel
//
//  Created by Eric Brito on 22/10/17.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit
import WebKit

class HeroViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var hero:Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    fileprivate func setup() {
        if let hero = hero, let firstUrl = hero.urls.first?.url {
            title = hero.name
            
            if let url = URL(string: firstUrl) {
                let request = URLRequest(url: url)
                
                webView.navigationDelegate = self
                webView.allowsBackForwardNavigationGestures = true
                webView.load(request)
            }
        }
    }
}

extension HeroViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
}
