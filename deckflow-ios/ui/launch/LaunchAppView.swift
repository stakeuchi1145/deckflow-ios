//
//  LaunchAppScrennView.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/29.
//

import SwiftUI

struct LaunchAppView: View {
    @ObservedObject var viewModel = LaunchAppViewModel.shared

    let onNavigate: (Route) -> Void

    var body: some View {
        ZStack {
            VStack {
                Image("title")
                    .resizable()
                    .scaledToFit()

                ProgressView()
                    .scaleEffect(4)
                    .padding(64)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            Task {
                if await viewModel.getUser() {
                    onNavigate(.home)
                } else {
                    onNavigate(.login)
                }
            }
        }
    }
}

#Preview {
    LaunchAppView() { route in
    }
}
