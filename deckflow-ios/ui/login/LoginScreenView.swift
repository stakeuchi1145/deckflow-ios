//
//  login.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/26.
//

import SwiftUI
import Combine

struct LoginScreenView: View {
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel.shared
    let onNavigate: (Route) -> Void

    @FocusState var focusedUserId: Bool
    @FocusState var focusedPassword: Bool
    @State var isLoading: Bool = false
    @State var isLogin: Bool = false

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image("title")
                        .resizable()
                        .frame(width: 256, height: 256)
                        .padding(.top, 32)
                }
                .frame(maxWidth: .infinity, alignment: .center)

                VStack {
                    Text("ID")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    TextField("メールアドレスを入力してください。", text: $viewModel.userId)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(.white)
                        .border(Color.gray, width: 1)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .focused($focusedUserId)
                        .onChange(of: focusedUserId) {
                            viewModel.onChangeIsLogin()
                        }
                        .onChange(of: viewModel.userId) {
                            viewModel.onChangeIsLogin()
                        }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)

                VStack {
                    Text("Password")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if self.viewModel.passHidden {
                        SecureField("パスワードを入力してください。", text: $viewModel.password)
                            .textContentType(.password)
                            .keyboardType(.asciiCapable)
                            .padding()
                            .background(.white)
                            .border(Color.gray, width: 1)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .focused($focusedPassword)
                            .overlay {
                                ZStack {
                                    Button(action: {
                                        viewModel.onChangePassHidden()
                                    }) {
                                        Image(systemName: "eye.slash.fill")
                                    }
                                    .foregroundColor(.gray.opacity(0.6))
                                    .padding()
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .onChange(of: focusedPassword) {
                                viewModel.onChangeIsLogin()
                            }
                            .onChange(of: viewModel.password) {
                                viewModel.onChangeIsLogin()
                            }
                    } else {
                        TextField("パスワードを入力してください。", text: $viewModel.password)
                            .textContentType(.password)
                            .keyboardType(.asciiCapableNumberPad)
                            .padding()
                            .background(.white)
                            .border(Color.gray, width: 1)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .focused($focusedPassword)
                            .overlay {
                                ZStack {
                                    Button(action: {
                                        viewModel.onChangePassHidden()
                                    }) {
                                        Image(systemName: "eye.fill")
                                    }
                                    .foregroundColor(.gray.opacity(0.6))
                                    .padding()
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .onChange(of: focusedPassword) {
                                viewModel.onChangeIsLogin()
                            }
                            .onChange(of: viewModel.password) {
                                viewModel.onChangeIsLogin()
                            }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                Button(action: {
                    Task {
                        isLoading = true
                        isLogin = false

                        do {
                            if try await viewModel.login() {
                                onNavigate(.home)
                            } else {
                                isLogin = true
                            }
                        } catch {
                            debugPrint(error)
                        }

                        isLoading = false
                    }
                }) {
                    Text("ログイン")
                        .frame(width: 100, height: 24)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(viewModel.isLogin ? Color(hex: "FF2196F3") : .gray)
                        .cornerRadius(8)
                }
                .disabled(!viewModel.isLogin)
                .padding(.top, 40)

                if isLogin {
                    Text("ログインに失敗しました。")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

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
        .ignoresSafeArea()
        .background(Color(hex: "#FFFAFAFA"))
        .onTapGesture {
            focusedUserId = false
            focusedPassword = false
        }
    }
}

#Preview {
    LoginScreenView() { _ in
    }
}
