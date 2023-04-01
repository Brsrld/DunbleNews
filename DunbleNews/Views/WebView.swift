//
//  WebView.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 30.03.2023.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    @Binding var showLoading: Bool
    
    func makeUIView(context: Context) -> some UIView {
        if let url = URL(string: url) {
            let webView = WKWebView()
            webView.navigationDelegate = context.coordinator
            let request = URLRequest(url: url)
                webView.load(request)
            return webView
        } else {
            return WKWebView()
        }
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator {
            showLoading = true
        } didFinish: {
            showLoading = false
        }
    }
}

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    
    var didStart: () -> Void
    var didFinish: () -> Void
    
    init(didStart: @escaping () -> Void,
         didFinish: @escaping () -> Void) {
        self.didStart = didStart
        self.didFinish = didFinish
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        didStart()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        didFinish()
    }
}
