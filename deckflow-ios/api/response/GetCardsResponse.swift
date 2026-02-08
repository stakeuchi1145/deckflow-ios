//
//  GetCardsResponse.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2026/01/04.
//

struct GetCardsResponse: Decodable {
    var cards: [CardDTO]
}

struct CardDTO: Decodable {
    var id: Int
    var name: String
    var number: String
    var cardType: String
    var packName: String
    var rarity: String
    var imageUrl: String
    var regulationMark: String
}
