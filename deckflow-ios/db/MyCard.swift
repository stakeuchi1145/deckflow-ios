//
//  Card.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/30.
//

import Foundation
import SwiftData

@Model
class MyCard {
    var myCardId: Int
    var cardName: String
    var imageURL: String
    var packName: String
    var quantity: Int

    init(id: Int, cardName: String, imageURL: String, packName: String, quantity: Int) {
        self.myCardId = id
        self.cardName = cardName
        self.imageURL = imageURL
        self.packName = packName
        self.quantity = quantity
    }
    
    convenience init(dto: MyCardDTO) {
        self.init(
            id: dto.id,
            cardName: dto.cardName,
            imageURL: dto.imageURL,
            packName: dto.packName,
            quantity: dto.quantity
        )
    }
}
