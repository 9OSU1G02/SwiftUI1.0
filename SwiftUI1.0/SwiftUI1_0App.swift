//
//  SwiftUI1_0App.swift
//  SwiftUI1.0
//
//  Created by Quốc Huy Nguyễn on 6/27/23.
//

import SwiftUI

@main
struct SwiftUI1_0App: App {
    var body: some Scene {
        WindowGroup {
            TabBar()
                .environmentObject(UserStore())
        }
    }
}
