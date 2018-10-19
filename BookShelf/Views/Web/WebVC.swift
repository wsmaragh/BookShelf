//
//  WebVC.swift
//  Books
//
//  Created by Winston Maragh on 10/18/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit
import WebKit
import AVFoundation


class WebVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    let webView = WebView()
    
    var link: String!
    
    init(link: String) {
        super.init(nibName: nil, bundle: nil)
        self.link = link
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupWebView()
    }
    
    private func setupNavBar(){
        self.navigationController?.navigationBar.topItem?.title = ""
        self.view = webView
    }
    
    private func setupWebView(){
        webView.webView.uiDelegate = self
        webView.webView.navigationDelegate = self

        guard let url = URL(string: self.link) else {return}
        let urlRequest = URLRequest(url: url)
        webView.webView.load(urlRequest)
        view.layoutIfNeeded()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.webView.spinner.startAnimating()
        self.webView.spinner.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.webView.spinner.startAnimating()
        self.webView.spinner.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.spinner.stopAnimating()
        self.webView.spinner.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.webView.spinner.stopAnimating()
        self.webView.spinner.isHidden = true
    }
    
}
