//
//  RootView.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/27.
//

import SwiftUI

struct RootView: View {
    @State private var path: [Route] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            LoginScreenView() { route in
                path = [route]
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .home:
                    HomeScreenView()
                default:
                    EmptyView()
                }
            }
        }
    }
}
