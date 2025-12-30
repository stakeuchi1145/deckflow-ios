//
//  HomeViewModel.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/28.
//

import Combine
import Foundation
import SwiftUI
import SwiftData

@MainActor
class HomeViewModel: ObservableObject {
    static let shared = HomeViewModel()
    
    let user = User.shared
    let mycardRepository = MyCardRepository.shared
    private let env = ProcessInfo.processInfo.environment

    private func baseURLString() throws -> String {
        guard let value = env["BASE_IMAGE_URL"],
              !value.isEmpty else {
            throw AppConfigError.missingBaseURL
        }
        return value
    }

    func getMyCards(context: ModelContext) async throws {
        do {
            try deleteAllMyCards(context: context)

            let imageUrl = try baseURLString()
            let token = await user.getToken()
            guard !token.isEmpty, !imageUrl.isEmpty else { return }

            let myCards = try await mycardRepository.getMyCards(token: token)
            guard !myCards.isEmpty else { return }

            myCards.forEach { card in
                card.imageURL = "\(imageUrl)/\(card.imageURL)"
                add(context: context, card: card)
            }
        } catch {
            debugPrint(error)
        }
    }
    
    private func add(context: ModelContext, card: MyCard) {
        context.insert(card)
    }
    
    private func deleteAllMyCards(context: ModelContext) throws {
        let descriptor = FetchDescriptor<MyCard>()
        let myCards = try context.fetch(descriptor)

        guard !myCards.isEmpty else {
            return
        }

        myCards.forEach { context.delete($0) }
    }
}
