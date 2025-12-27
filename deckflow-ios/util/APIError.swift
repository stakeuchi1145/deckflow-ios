//
//  APIError.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/27.
//

import Foundation
import Alamofire

enum APIError: Error {
    case invalidConfiguration               // ベースURLなどの設定ミス
    case network(AFError)                   // ネットワーク/HTTPレベル
    case server(statusCode: Int, data: Data?) // サーバーエラー(4xx/5xx)
    case decoding(DecodingError)            // デコード失敗
    case unknown(Error)                     // 上記以外
}
