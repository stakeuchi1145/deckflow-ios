//
//  SelectMyCardScreenViewModel.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2026/01/04.
//

import Combine
import Foundation
import SwiftData

class SelectMyCardScreenViewModel: ObservableObject {
    static let shared = SelectMyCardScreenViewModel()

    let user = User.shared
    let cardRepository = CardRepository.shared
    private let env = ProcessInfo.processInfo.environment

    private func baseURLString() throws -> String {
        guard let value = env["BASE_IMAGE_URL"],
              !value.isEmpty else {
            throw AppConfigError.missingBaseURL
        }
        return value
    }

    func getCards(context: ModelContext) async throws {
        do {
            try deleteAllCards(context: context)

            let imageUrl = try baseURLString()
            let token = await user.getToken()
            guard !token.isEmpty, !imageUrl.isEmpty else { return }

            let cards = try await cardRepository.getCards(token: token)
            guard !cards.isEmpty else { return }

            cards.forEach { card in
                card.imageURL = "\(imageUrl)/\(card.imageURL)"
                add(context: context, card: card)
            }
        } catch {
            debugPrint(error)
        }
    }

    func add(context: ModelContext, card: Card) {
        context.insert(card)
    }

    func deleteAllCards(context: ModelContext) throws {
        let descriptor = FetchDescriptor<Card>()
        let cards = try context.fetch(descriptor)

        guard !cards.isEmpty else {
            return
        }

        cards.forEach { context.delete($0) }
        try context.save()
    }
}
