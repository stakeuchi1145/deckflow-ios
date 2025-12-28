//
//  GetMyCardsResponse.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/28.
//

struct GetMyCardsResponse: Decodable {
    let myCards: [MyCard]
}

struct MyCard: Decodable {
    let id: Int
    let cardName: String
    let imageURL: String
    let packName: String
    let quantity: Int
}
