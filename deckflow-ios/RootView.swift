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
            LaunchAppView() { route in
                path = [route]
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .login:
                    LoginScreenView() { route in
                        path = [route]
                    }
                case .home:
                    HomeScreenView() { route in
                        path.append(route)
                    }
                case .registerMyCard(let id):
                    MyCardRegisterScreenView(cardId: id, onNavigate: {route in
                        path.append(route)
                    }, onBack: {
                        path = [.home]
                    })
                case .selectMyCard:
                    SelectMyCardScreenView(onNavigate: {route in
                        path.removeLast()
                        path.append(route)
                    }, onBack: {
                        path.removeLast()
                    })
                default:
                    EmptyView()
                }
            }
        }
    }
}
