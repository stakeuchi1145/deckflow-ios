//
//  APIService.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/27.
//

import Alamofire
import Foundation

final class APIService {
    static let shared = APIService()

    private let decoder = JSONDecoder()
    let env = ProcessInfo.processInfo.environment

    private func baseURLString() throws -> String {
        guard let value = env["BASE_API_URL"],
              !value.isEmpty else {
            throw AppConfigError.missingBaseURL
        }
        return value
    }

    func getUserInfo(token: String) async throws -> GetLoginResponse {
        do {
            let baseURL = try baseURLString()
            let url = "\(baseURL)/me"

            let request = AF.request(
                url,
                method: .get,
                headers: getHeaders(token: token)
            )
            .validate(statusCode: 200..<300)

            let data = try await request.serializingData().value
            return try decoder.decode(GetLoginResponse.self, from: data)
        } catch let _ as AppConfigError {
            // baseURL の取得失敗など
            throw APIError.invalidConfiguration
        } catch let afError as AFError {
            // HTTP ステータスでの失敗などを取り出したい場合
            if case let .responseValidationFailed(reason) = afError,
               case let .unacceptableStatusCode(code) = reason {
                // レスポンスボディを読みたい場合は serializingData() の結果から statusCode と data を拾う実装にする
                throw APIError.server(statusCode: code, data: nil)
            }
            throw APIError.network(afError)
        } catch let decodingError as DecodingError {
            throw APIError.decoding(decodingError)

        } catch {
            throw APIError.unknown(error)
        }
    }

    private func getHeaders(token: String) -> HTTPHeaders {
        ["Authorization": "Bearer \(token)"]
    }
}

