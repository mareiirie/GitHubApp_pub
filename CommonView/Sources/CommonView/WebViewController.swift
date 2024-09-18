//
//  WebViewController.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import SwiftUI
import UIKit
import WebKit

public class WebViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    let url: URL

    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
}

public struct ViewControllerRepresentable: UIViewControllerRepresentable{

    let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func makeUIViewController(context: Context) -> WebViewController {
        return WebViewController(url: url)
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
