//
//  MyCardRepository.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/28.
//

import Foundation

class MyCardRepository {
    static let shared = MyCardRepository()

    let apiService = APIService.shared

    func getMyCards(token: String) async throws -> [MyCard] {
        var myCards: [MyCard] = []
        let result = try await apiService.getUserCards(token: token)
        result.forEach { dto in
            myCards.append(MyCard(dto: dto))
        }

        return myCards
    }
}
