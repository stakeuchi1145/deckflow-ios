//
//  LoginRepository.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/27.
//

import FirebaseAuth

class LoginRepository {
    static var shared = LoginRepository()

    let apiService = APIService.shared

    func login(email: String, password: String) async throws -> String {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        
        return try await result.user.getIDTokenResult().token
    }

    func getCurrentUser() async throws -> String {
        guard let currentUser = Auth.auth().currentUser else { return "" }
        return try await currentUser.getIDToken()
    }

    func getUser(token: String) async throws -> String {
        return try await apiService.getUserInfo(token: token).displayName
    }
}
