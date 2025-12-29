//
//  MyCardRepository.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/28.
//

class MyCardRepository {
    static let shared = MyCardRepository()
    
    let apiService = APIService.shared

    func getMyCards(token: String) async throws -> [MyCard] {
        return try await apiService.getUserCards(token: token)
    }
}
