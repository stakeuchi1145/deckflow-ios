//
//  User.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/28.
//

import Foundation

class User {
    static let shared = User()
    private let queue = DispatchQueue(label: "com.deckflow.user", attributes: .concurrent)
    private var _token: String = ""
    private var _displayName: String = ""

    var token: String {
        get { queue.sync { _token }}
        set { queue.async(flags: .barrier) { self._token = newValue } }
    }
    var displayName: String {
        get { queue.sync { _displayName }}
        set { queue.sync(flags: .barrier) { self._displayName = newValue } }
    }
}
