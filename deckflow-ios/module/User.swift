//
//  User.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/28.
//

import Foundation

actor User {
    static let shared = User()
    private let queue = DispatchQueue(label: "com.deckflow.user", attributes: .concurrent)
    private var token: String = ""
    private var displayName: String = ""
    
    func setToken(token: String) {
        self.token = token
    }

    func getToken() -> String {
        return self.token
    }
}
