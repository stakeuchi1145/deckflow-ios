//
//  AppConfigError.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/27.
//

import Foundation

enum AppConfigError: LocalizedError {
    case missingBaseURL
    case invalidBaseURL(String)

    var errorDescription: String? {
        switch self {
        case .missingBaseURL:
            return "APIのBase URLが設定されていません"
        case .invalidBaseURL(let value):
            return "不正なBase URLです: \(value)"
        }
    }
}
