//
//  HomeScreenView.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/27.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("ホーム画面")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
        .toolbar(.hidden, for: .navigationBar)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeScreenView()
}
