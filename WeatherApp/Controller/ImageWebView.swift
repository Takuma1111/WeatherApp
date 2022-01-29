//
//  ImageWebView.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/29.
//

import SwiftUI

struct ImageWebView: UIViewRepresentable {
    typealias UIViewType = 

    let imageURL: String
    let imageSize: CGSize

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let html = """
            <!DOCTYPE html><html><head><meta charset='utf-8'></head><body style="width:100vw; height:100vh; text-align:center;"><img src='\(imageURL)' width=\(imageSize.width * UIScreen.main.scale)px height=\(imageSize.height * UIScreen.main.scale)px></body></html>
            """
        webView.loadHTMLString(html, baseURL: nil)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
