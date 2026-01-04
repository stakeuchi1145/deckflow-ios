//
//  Card.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2026/01/04.
//

import Foundation
import SwiftData

@Model
class Card: Identifiable {
    @Attribute(.unique) var id: String
    var cardId: Int
    var cardName: String
    var cardNumber: String
    var cardType: String
    var packName: String
    var rarity: String
    var imageURL: String
    var regulationMark: String

    init(id: String = UUID().uuidString, cardId: Int, cardName: String, cardNumber: String, cardType: String, packName: String, rarity: String, imageURL: String, regulationMark: String) {
        self.id = id
        self.cardId = cardId
        self.cardName = cardName
        self.cardNumber = cardNumber
        self.cardType = cardType
        self.packName = packName
        self.rarity = rarity
        self.imageURL = imageURL
        self.regulationMark = regulationMark
    }
    
    convenience init(dto: CardDTO) {
        self.init(
            cardId: dto.id,
            cardName: dto.name,
            cardNumber: dto.number,
            cardType: dto.cardType,
            packName: dto.packName,
            rarity: dto.rarity,
            imageURL: dto.imageUrl,
            regulationMark: dto.regulationMark
        )
    }
}
