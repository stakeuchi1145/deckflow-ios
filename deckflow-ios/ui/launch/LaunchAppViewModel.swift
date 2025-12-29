//
//  LaunchAppViewModel.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/29.
//

import Combine
import Foundation

class LaunchAppViewModel: ObservableObject {
    static let shared = LaunchAppViewModel()

    let userRepository = LoginRepository.shared
    let user = User.shared
    
    func getUser() async -> Bool {
        do {
            let token = try await userRepository.getCurrentUser()
            guard !token.isEmpty else { return false }

            await user.setToken(token: token)
            debugPrint("token: \(await user.getToken())")

            return true
        } catch {
            debugPrint(error)
            return false
        }
    }
}
