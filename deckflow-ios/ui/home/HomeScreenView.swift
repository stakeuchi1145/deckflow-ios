//
//  HomeScreenView.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/27.
//

import SwiftUI

struct HomeScreenView: View {
    @State var searchCardText: String = ""

    var body: some View {
        ZStack {
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
                    .border(Color.gray, width: 1)

                    Button(action: {}) {
                        Text("Filter")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color(hex: "#FF2196F3"))
                            .cornerRadius(20)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
        .toolbar(.hidden, for: .navigationBar)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeScreenView()
}
