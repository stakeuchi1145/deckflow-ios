//
//  MyCardRegisterScreenViewModel.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2026/01/04.
//

import Combine
import Foundation
import SwiftData

class MyCardRegisterScreenViewModel: ObservableObject {
    static let shared = MyCardRegisterScreenViewModel()
    
    func fetchCards(context: ModelContext, cardId: String) -> [Card] {
        let descriptor = FetchDescriptor<Card>(
            predicate: #Predicate { $0.id == cardId }
        )
        
        return try! context.fetch(descriptor)
    }
}
