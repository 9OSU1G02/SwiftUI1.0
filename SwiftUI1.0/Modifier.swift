//
//  Modifier.swift
//  SwiftUI1.0
//
//  Created by Quốc Huy Nguyễn on 6/30/23.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 10)
    }
}

struct FontModifier: ViewModifier {
    var style: Font.TextStyle = .body
    func body(content: Content) -> some View {
        content.font(.system(style, design: .default))
    }
}

struct CustomFontModifier: ViewModifier {
    var size: CGFloat = 28
    func body(content: Content) -> some View {
        content.font(.custom("WorkSans-Bold", size: 28))
    }
}
