//
//  User.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/28.
//

import Foundation

class User {
    static let shared = User()

    var token: String = ""
    var displayName: String = ""
}
