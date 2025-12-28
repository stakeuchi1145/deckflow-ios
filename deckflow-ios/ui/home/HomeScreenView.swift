//
//  HomeScreenView.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/27.
//

import SwiftUI

struct HomeScreenView: View {
    @ObservedObject private var viewModel = HomeViewModel.shared

    @State var searchCardText: String = ""
    @State var isLoading: Bool = false

    var body: some View {
        ZStack {
            VStack {
                VStack {
                    ZStack {
                        Text("My Cards")
                            .font(.system(size: 32))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Button(action: {}) {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .frame(width: 14, height: 14)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding()
                        }
                    }
                    .frame(maxWidth: .infinity)

                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .padding(.leading, 8)

                            TextField("検索", text: $searchCardText)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(10)

                        Button(action: {}) {
                            Text("Filter")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color(hex: "#FF2196F3"))
                                .cornerRadius(20)
                        }
                    }
                    .padding(.bottom, 8)

                }
                .padding(.horizontal, 10)


                ZStack {
                    ZStack {
                        Divider()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .background(.gray.opacity(0.2))
                    }
                    .frame(maxHeight: .infinity, alignment: .top)

                    VStack {

                        if viewModel.cards.isEmpty {
                            Text("カードが見つかりません。")
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        } else {
                            ScrollView([.vertical]) {
                                LazyVStack {
                                    ForEach(viewModel.cards, id: \.self) { card in
                                        let url = "https://minio.deckflow.stakeuchi.work/\(card.imageURL)"

                                        HStack {
                                            AsyncImage(url: URL(string: url)) { phase in
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
                                            .frame(height: 100)
                                            .padding(12)

                                            VStack {
                                                Text(card.cardName)
                                                    .font(.system(size: 18))
                                                    .fontWeight(.semibold)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding(.bottom, 2)

                                                Text(card.packName)
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.gray.opacity(0.8))
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            }
                                            .padding(12)

                                            VStack {
                                                Text("×\(card.quantity)")
                                                    .font(.system(size: 14))
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                                    .padding(8)
                                            }
                                            .background(Color(hex: "#FF2196F3"))
                                            .cornerRadius(8)

                                            Image(systemName: "greaterthan")
                                                .foregroundColor(.gray.opacity(0.6))
                                                .padding(.trailing, 8)
                                        }
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                        .background(.white)
                                        .cornerRadius(10)
                                        .padding(8)
                                    }
                                }
                            }
                        }
                    }

                    ZStack {
                        Button(action: {}) {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding()
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(50)
                                .shadow(color: .gray.opacity(0.4), radius: 0.8, x: 1, y: 2)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding()

                    ZStack {
                        Divider()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .background(.gray.opacity(0.2))
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
                .background(Color(hex: "#FFFAFAFA"))

                VStack {
                    HStack {
                        Button(action: {}) {
                            VStack {
                                Image(systemName: "house.fill")
                                    .padding(.bottom, 2)

                                Text("ホーム")
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }

            if isLoading {
                ZStack {
                    VStack {
                        ProgressView()
                            .tint(.white)
                            .scaleEffect(4.0)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(.gray.opacity(0.4))
            }
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            Task {
                try await viewModel.getMyCards()
            }
        }
    }
}

#Preview {
    HomeScreenView()
}
