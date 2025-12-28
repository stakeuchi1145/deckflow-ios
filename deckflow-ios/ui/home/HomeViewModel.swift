//
//  HomeViewModel.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/28.
//

import Combine
import Foundation
import SwiftUI

struct Card: Hashable, Identifiable {
    let id: Int
    let cardName: String
    let imageURL: String
    let packName: String
    let quantity: Int
}

class HomeViewModel: ObservableObject {
    static let shared = HomeViewModel()

    @Published var cards: [Card] = []
}
