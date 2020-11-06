//
//  WebViewController.swift
//  CraveApp
//
//  Created by Alex Cole on 10/28/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    //MARK: - Class variables
    
    private let webView = WKWebView()
    
    var url: URL!

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func viewWillLayoutSubviews() {
        webView.autoPinEdgesToSuperviewEdges()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
}

//MARK: - WebKit Delegates

extension WebViewController: WKNavigationDelegate, WKUIDelegate {
    
}
