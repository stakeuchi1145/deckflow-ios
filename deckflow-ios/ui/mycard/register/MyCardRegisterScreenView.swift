//
//  MyCardRegisterView.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/30.
//

import SwiftUI

struct MyCardRegisterScreenView: View {
    let cardId: Int?
    let onNavigate: (Route) -> Void
    let onBack: () -> Void
    
    @State var quantity: String = ""

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
                    }
                    .background(.white)
                    .cornerRadius(20)
                    .padding()

                    VStack {
                        Text("Quantity")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray.opacity(0.6))
                            .padding(.horizontal, 16)
                            .padding(.top, 32)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        HStack {
                            Image(systemName: "minus")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                                .padding()
                                .background(.gray.opacity(0.4))
                                .cornerRadius(10)
                            
                            TextField("0", text: $quantity)
                                .textContentType(.shipmentTrackingNumber)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .padding(.vertical, 14)
                                .background(.gray.opacity(0.2))
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.gray.opacity(0.4), lineWidth: 1)
                                )

                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                                .padding()
                                .background(.gray.opacity(0.4))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .background(.white)
                    .cornerRadius(20)
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#FFFAFAFA"))
    }
}

#Preview {
    MyCardRegisterScreenView(cardId: nil, onNavigate: {route in}, onBack: {})
}
