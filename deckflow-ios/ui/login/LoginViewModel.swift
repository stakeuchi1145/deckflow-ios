//
//  LoginViewModel.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/27.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    static let shared = LoginViewModel()
    
    let loginRepository = LoginRepository.shared
    @Published var userId: String = ""
    @Published var password: String = ""
    @Published var passHidden: Bool = true
    @Published var isLogin: Bool = false
    
    func onChangePassHidden() {
        passHidden = !passHidden
    }

    func onChangeIsLogin() {
        isLogin = !userId.isEmpty && !password.isEmpty
    }
    
    func login() async throws -> Bool {
        let token = try await loginRepository.login(email: userId, password: password)
        debugPrint("token: \(token)")
        
        return !token.isEmpty
    }
}
