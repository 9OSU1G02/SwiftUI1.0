//
//  LoadingView.swift
//  SwiftUI1.0
//
//  Created by Quốc Huy Nguyễn on 7/6/23.
//

import SwiftUI
import Lottie
struct LoadingView: View {
    var body: some View {
        VStack {
            LottieView(filename: "loading")
                .frame(width: 200, height: 200)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
