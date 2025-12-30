//
//  deckflow_iosApp.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/26.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

enum Route: Hashable {
    case login
    case home
    case registerMyCard(id: Int?)
    case selectMyCard
    case unknown
}

@main
struct DeckflowApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
