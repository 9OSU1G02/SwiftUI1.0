//
//  UpdateDetail.swift
//  SwiftUI1.0
//
//  Created by Quốc Huy Nguyễn on 6/29/23.
//

import SwiftUI

struct UpdateDetail: View {
    var update: Update
    var body: some View {
        List {
            VStack(spacing: 20) {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .listStyle(.plain)
        .navigationBarTitle(update.title, displayMode: .large)
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail(update: updateData[0])
    }
}
