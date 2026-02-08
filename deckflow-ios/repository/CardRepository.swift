//
//  CardRepository.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2026/01/04.
//

import Foundation

class CardRepository {
    static let shared = CardRepository()
    let apiService = APIService.shared

    func getCards(token: String) async throws -> [Card] {
        var cards: [Card] = []
        let response = try await apiService.getCards(token: token)
        response.forEach { card in
            cards.append(Card(dto: card))
        }

        return cards
    }
}
