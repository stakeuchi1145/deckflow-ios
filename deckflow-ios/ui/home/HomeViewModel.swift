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
    
    let user = User.shared
    let mycardRepository = MyCardRepository.shared
    private let env = ProcessInfo.processInfo.environment

    private func baseURLString() throws -> String {
        guard let value = env["BASE_API_URL"],
              !value.isEmpty else {
            throw AppConfigError.missingBaseURL
        }
        return value
    }

    @Published var cards: [Card] = []

    func getMyCards() async throws -> Bool {
        do {
            cards.removeAll()
            let imageUrl = try baseURLString()
            guard !user.token.isEmpty, !imageUrl.isEmpty else { return false }

            let myCards = try await mycardRepository.getMyCards(token: user.token)
            myCards.forEach { card in
                cards.append(
                    Card(
                        id: card.id,
                        cardName: card.cardName,
                        imageURL: "\(imageUrl)/\(card.imageURL)",
                        packName: card.packName,
                        quantity: card.quantity
                    )
                )
            }
        } catch {
            debugPrint(error)
        }
        
        return !cards.isEmpty
    }
}
