//
//  SelectMyCardScreenView.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/30.
//

import SwiftUI
import SwiftData

struct SelectMyCardScreenView: View {
    let onNavigate: (Route) -> Void
    let onBack: () -> Void

    @Query private var cards: [MyCard]
    
    @State private var imageUrl: String = ""
    private let env = ProcessInfo.processInfo.environment
    private func baseURLString() throws -> String {
        guard let value = env["BASE_IMAGE_URL"],
              !value.isEmpty else {
            throw AppConfigError.missingBaseURL
        }
        return value
    }

    var body: some View {
        ZStack {
            VStack {
                VStack {
                    ZStack {
                        Button(action: onBack) {
                            Image("arrow_back")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: 24, alignment: .leading)
                        }
                        .padding(.leading, 10)

                        Text("カード選択")
                            .font(.system(size: 32))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.horizontal, 10)

                    VStack {}.frame(maxWidth: .infinity, maxHeight: 1).background(.gray.opacity(0.2))
                }
                .background(.white)

                ScrollView {
                    LazyVStack {
                        ForEach(cards, id: \.self) { card in
                            HStack {
                                AsyncImage(url: URL(string: "\(imageUrl)/\(card.imageURL)")) { phase in
                                    switch phase {
                                    case .empty:
                                        // 取得中（ローディング）
                                        ProgressView()
                                        
                                    case .success(let image):
                                        // 成功
                                        image
                                            .resizable()
                                            .scaledToFit()
                                        
                                    case .failure:
                                        // 失敗
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.gray)
                                        
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .frame(height: 120)
                                .padding()

                                VStack {
                                    Text("\(card.cardName)")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    Text("\(card.packName)")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray.opacity(0.6))
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    HStack {
                                        Text("レアリティ: \(card.rarity)")
                                            .font(.system(size: 14))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding(8)
                                            .background(Color(hex: "#FF2196F3"))
                                            .cornerRadius(10)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 4)
                                }
                                .frame(maxHeight: .infinity, alignment: .topLeading)
                                .padding(.vertical, 16)

                                Image("arrow_forward")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(.trailing, 16)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white)
                            .cornerRadius(10)
                            .padding()
                            .onTapGesture {
                                onNavigate(.registerMyCard(id: card.myCardId))
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .navigationBarBackButtonHidden(true)
        .background(Color(hex: "#FFFAFAFA"))
        .task {
            Task {
                do {
                    imageUrl = try baseURLString()
                } catch {
                    debugPrint(error)
                }
            }
        }
    }
}

#Preview {
    SelectMyCardScreenView(onNavigate: { route in}, onBack: {})
}
