//
//  UpdateStore.swift
//  SwiftUI1.0
//
//  Created by Quốc Huy Nguyễn on 6/29/23.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
