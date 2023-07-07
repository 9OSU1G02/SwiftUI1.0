//
//  UserStore.swift
//  SwiftUI1.0
//
//  Created by Quốc Huy Nguyễn on 7/7/23.
//

import Combine
import SwiftUI
class UserStore: ObservableObject {
    @Published var showLogin = false
    @AppStorage("isLogged") var isLogged = false
}
