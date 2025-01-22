//
//  WebView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 1/22/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            return WKWebView()
        }
        
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
    
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        guard let url = URL(string: url) else {
            return
        }
        
        uiView.load(URLRequest(url: url))
    }
}
