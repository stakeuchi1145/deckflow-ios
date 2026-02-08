//
//  MyCardRegisterView.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/30.
//

import SwiftUI
import SwiftData

struct MyCardRegisterScreenView: View {
    let cardId: String
    let onNavigate: (Route) -> Void
    let onBack: () -> Void

    @ObservedObject var viewModel = MyCardRegisterScreenViewModel.shared
    @Environment(\.modelContext) private var context

    @Query private var cards: [Card]

    @State var quantity: Int = 0
    @State var imageUrl: String = ""
    @State var locationText: String = ""
    
    @FocusState var focused: Bool

    private let env = ProcessInfo.processInfo.environment
    private func baseURLString() throws -> String {
        guard let value = env["BASE_IMAGE_URL"],
              !value.isEmpty else {
            throw AppConfigError.missingBaseURL
        }
        return value
    }

    var filterCard: [Card] {
        if cardId.isEmpty {
            return [Card(cardId: 2, cardName: "ピカチュウex", cardNumber: "033/106", cardType: "", packName: "超電ブレイカー", rarity: "RR", imageURL: "\(imageUrl)/card-images/sv8/033.jpg", regulationMark: "レギュレーションマーク G")]
        }

        return cards.filter { $0.id.contains(cardId) }
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

                        Text("マイカード登録")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.horizontal, 10)

                    VStack{}.frame(maxWidth: .infinity, maxHeight: 1).background(.gray.opacity(0.2))
                }
                .frame(maxWidth: .infinity)
                .background(.white)

                VStack {
                    VStack {
                        if filterCard.isEmpty {
                            VStack {
                                VStack {
                                    Image(systemName: "camera.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.gray.opacity(0.6))
                                        .frame(maxWidth: .infinity, maxHeight: 60)
                                    
                                    Text("No Image")
                                        .font(.system(size: 24))
                                        .foregroundColor(.gray.opacity(0.8))
                                }
                                .padding(.vertical, 48)
                            }
                            .background(.gray.opacity(0.4))
                            .cornerRadius(20)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)

                            Button(action: {
                                onNavigate(.selectMyCard)
                            }) {
                                Text("カード選択")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(hex: "#FF2196F3"))
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                        } else {
                            HStack {
                                AsyncImage(url: URL(string: filterCard.first?.imageURL ?? "")) { phase in
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
                                .frame(height: 180)
                                .padding()

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(filterCard.first?.cardName ?? "")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)

                                    Text(filterCard.first?.packName ?? "")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray.opacity(0.6))

                                    HStack {
                                        Text("レアリティ:")
                                            .font(.system(size: 16))
                                            .foregroundColor(Color(hex: "#5AC8FA"))

                                        Text(filterCard.first?.rarity ?? "")
                                            .font(.system(size: 16))
                                            .foregroundColor(Color(hex: "#5AC8FA"))
                                    }
                                    .padding()
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(lineWidth: 1)
                                            .foregroundColor(Color(hex: "#5AC8FA"))
                                    }
                                    .background(Color(hex: "#EAF6FF").opacity(0.4))
                                    .cornerRadius(20)
                                    .shadow(color: .gray.opacity(0.2), radius: 0, x: 1, y: 2)
                                    .padding(.top, 8)

                                    Button(action: {}) {
                                        HStack {
                                            Text("他のカードを選択")

                                            Image("arrow_forward")
                                                .renderingMode(.template)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(.gray.opacity(0.4))
                                        }
                                    }
                                    .padding(.vertical, 12)
                                }
                                .frame(alignment: .top)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .background(.white)
                    .cornerRadius(20)
                    .padding()

                    VStack {
                        Text("Quantity")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(filterCard.isEmpty ? .gray.opacity(0.6) : .black)
                            .padding(.horizontal, 16)
                            .padding(.top, 32)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        HStack {
                            Button(action: {
                                guard quantity > 0 else { return }
                                quantity -= 1
                            }) {
                                Image(systemName: "minus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                                    .padding()
                            }
                            .background(filterCard.isEmpty || quantity == 0 ? .gray.opacity(0.4) : Color(hex: "#1E88E5"))
                            .cornerRadius(10)
                            .disabled(filterCard.isEmpty || quantity == 0)
                            
                            Text("\(quantity)")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .foregroundColor(Color(hex: "#8E8E93"))
                                .background(filterCard.isEmpty ? .gray.opacity(0.2) : .white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(hex: "#D1D1D6"), lineWidth: 1)
                                )
                            
                            Button(action: {
                                guard quantity >= 0 else { return }
                                quantity += 1
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                                    .padding()
                            }
                            .background(filterCard.isEmpty ? .gray.opacity(0.4) : Color(hex: "#1E88E5"))
                            .cornerRadius(10)
                            .disabled(filterCard.isEmpty)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .background(.white)
                    .cornerRadius(20)
                    .padding()
                    
                    VStack {
                        Text("location")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(filterCard.isEmpty ? .gray.opacity(0.6) : .black)
                            .padding(.horizontal, 16)
                            .padding(.top, 32)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .background(.white)
                    .cornerRadius(20)
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .onTapGesture {
                focused = false
            }
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#FFFAFAFA"))
        .task {
            do {
                imageUrl = try baseURLString()
            } catch {
                debugPrint(error)
            }
        }
        .onTapGesture {
            focused = false
        }
    }
}

#Preview {
    MyCardRegisterScreenView(cardId: "", onNavigate: {route in}, onBack: {})
}
