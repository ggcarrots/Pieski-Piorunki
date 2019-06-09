//
//  InfoView.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import WebKit


class InfoView: BoroView {
    private let webView: WKWebView = WKWebView(frame: CGRect.zero)
    
    
    var info: Info? {
        didSet {
            print("\(info?.title)")
            display(info: info)
            setNeedsLayout()
        }
    }
    
    override func initialize() {
        super.initialize()
        addSubview(webView)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        webView.frame = bounds
        
        display(info: info)
    }
    
    
    func display(info: Info?) {
        let html: String
        if let info = info {
            html = UWWordpressViewHtmlCreator.create(
                title: info.title,
                content: info.text,
                width: bounds.width
            )
        } else {
            html = UWWordpressViewHtmlCreator.empty()
        }
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    
}


enum UWWordpressViewHtmlCreator {
    
    
    static func empty() -> String {
        return "<!DOCTYPE html><html></html>"
    }
    
    
    static func create(
        title: String,
        content: String,
        width: CGFloat
        ) -> String {
        return create(
            title: title,
            content: content,
            width: width,
            titleH: 20.0,
            h1: 30.0,
            h2: 28.0,
            h3: 26.0,
            h4: 26.0,
            h5: 20.0,
            h6: 16.0,
            contentH: 14.0
        )
    }
    
    static func create(
        title: String,
        content: String,
        width: CGFloat,
        titleH: CGFloat,
        h1: CGFloat,
        h2: CGFloat,
        h3: CGFloat,
        h4: CGFloat,
        h5: CGFloat,
        h6: CGFloat,
        contentH: CGFloat
        ) -> String {
        
        let header: String = getHeader(
            width: width,
            titleH: titleH, h1: h1, h2: h2, h3: h3,
            h4: h4, h5: h5, h6: h6, contentH: contentH
        )
        return """
        <!DOCTYPE html>
        <html>
        <head>
        \(header)
        </head>
        <body>
        \(getBody(title: title, content: content))
        </body>
        </html>
        """
    }
    
    
    /// content of body tag
    private static func getBody(
        title: String, content: String
        ) -> String {
        return"""
        \(getTitle(title))
        \(content)
        """
    }
    
    private static func getTitle(_ title: String) -> String {
        return """
        <div class="usos-title">
        <p>\(title)</p>
        </div>
        """
    }
    
    /// render image
    private static func getImage(imageUrl: String?) -> String {
        guard let imageUrl: String = imageUrl else { return "" }
        return """
        <img src="\(imageUrl)">
        """
    }
    
    
    /// content of head tag
    private static func getHeader(
        width: CGFloat,
        titleH: CGFloat,
        h1: CGFloat,
        h2: CGFloat,
        h3: CGFloat,
        h4: CGFloat,
        h5: CGFloat,
        h6: CGFloat,
        contentH: CGFloat
        ) -> String {
        let custom: String = customCss(
            width: width, titleH: titleH, h1: h1, h2: h2, h3: h3,
            h4: h4, h5: h5, h6: h6, contentH: contentH
        )
        return """
        <meta name="viewport"
        content="width=device-width,
        initial-scale=1,
        maximum-scale=1"
        />
        \(custom)
        """
        
    }
    
    
    /// set fonts in WebView
    private static func customCss(
        width: CGFloat,
        titleH: CGFloat,
        h1: CGFloat,
        h2: CGFloat,
        h3: CGFloat,
        h4: CGFloat,
        h5: CGFloat,
        h6: CGFloat,
        contentH: CGFloat
        ) -> String {
        let width: CGFloat = width - CGFloat(5.0)
        let pixelWidth: Int = Int(width * UIScreen.main.scale)
        
        let margin: Int = Int(CGFloat(8.0) * UIScreen.main.scale)
        let bottomPadding: Int = Int(CGFloat(12.0) * UIScreen.main.scale)

        return """
        <style>
        body {
        background-color: #ffffff;
        font-family: -apple-system;
        }
        .main-wrapper {
        width: auto;
        max-width: \(pixelWidth)px;
        min-width: 1px;
        padding-top: 0px;
        padding-bottom: \(bottomPadding)px;
        }
        .usos-title {
        font-size: \(titleH)px;
        font-weight: bold;
        
        }
        .usos-padding {
        margin-left: \(margin)px;
        margin-right: \(margin)px;
        }
        .usos-content {
        font-size: \(contentH)px;
        }
        
        h1 {
        font-size: \(h1)px;
        }
        h2 {
        font-size: \(h2)px;
        }
        h3 {
        font-size: \(h3)px;
        }
        h4 {
        font-size: \(h4)px;
        }
        h5 {
        font-size: \(h5)px;
        }
        h6 {
        font-size: \(h6)px;
        }
        </style>
        """
    }
}


