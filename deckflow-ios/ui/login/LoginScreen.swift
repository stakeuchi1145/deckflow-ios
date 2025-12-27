//
//  login.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/26.
//

import SwiftUI

struct LoginScreen: View {
    @State var id: String = ""
    @State var password: String = ""
    @State var passHidden: Bool = true

    var body: some View {
        VStack {
            HStack {
                Image("title")
                    .resizable()
                    .frame(width: 256, height: 256)
            }
            .frame(maxWidth: .infinity, alignment: .center)

            VStack {
                Text("ID")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                TextField("メールアドレスを入力してください。", text: $id)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .background(.white)
                    .padding()
                    .border(Color.gray, width: 1)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)

            VStack {
                Text("Password")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if self.passHidden {
                    SecureField("パスワードを入力してください。", text: $password)
                        .textContentType(.password)
                        .keyboardType(.asciiCapable)
                        .background(.white)
                        .padding()
                        .border(Color.gray, width: 1)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .overlay {
                            ZStack {
                                Button(action: {
                                    passHidden = false
                                }) {
                                    Image(systemName: "eye.slash.fill")
                                }
                                .foregroundColor(.black)
                                .padding()
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                } else {
                    TextField("パスワードを入力してください。", text: $password)
                        .textContentType(.emailAddress)
                        .keyboardType(.asciiCapableNumberPad)
                        .background(.white)
                        .padding()
                        .border(Color.gray, width: 1)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .overlay {
                            ZStack {
                                Button(action: {
                                    passHidden = true
                                }) {
                                    Image(systemName: "eye.fill")
                                }
                                .foregroundColor(.black)
                                .padding()
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            Button(action: {}) {
                Text("ログイン")
                    .frame(width: 100, height: 24)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(8)
            }
            .padding(.top, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(hex: "#FFFAFAFA"))
        .padding()
    }
}

#Preview {
    LoginScreen()
}
