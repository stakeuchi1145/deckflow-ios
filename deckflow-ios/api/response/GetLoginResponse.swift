//
//  GetLoginResponse.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/27.
//

import Foundation

struct GetLoginResponse: Decodable, Sendable {
    let displayName: String
    let email: String
    let createdAt: String
    let updatedAt: String
}
