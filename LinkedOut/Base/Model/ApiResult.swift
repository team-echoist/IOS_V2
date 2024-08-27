//
//  ApiResult.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import RxSwift
import RxCocoa
import Moya

// MARK: - ApiWebResult

public struct ApiWebResult: Codable {
    let statusCode: Int?
    let success: Bool
    let message: String?

//    enum CodingKeys: String, CodingKey {
//        case code = "code"
//        case message = "message"
//    }
}

// MARK: - ApiResult

public struct ApiResult<T: Codable>: Codable {
    public var result: ApiWebResult?
    public var data: T?
}

public struct ApiResultArray<T: Codable>: Codable {
    public var result: ApiWebResult?    
    public var data: T?
}

// MARK: - FoodinkoError
public struct LinkedOutError: LocalizedError, CustomStringConvertible {
    public var description: String
    
    public var title: String!
    public var code: Int = 0
    
    private static let emptyTitle = "오류"
    private static let emptyDesc = "알수 없는 오류가 발생했습니다."
    private static let emptyCode = "Error Code"
    
    public init(_ e: Error?) {
        if let err = e as? HTTPURLResponse {
            self.init(err)
        } else if let err = e as? MoyaError {
            self.init(err)
        }
        else if let err = e as? LinkedOutError {
            self.init(title: err.title, description: err.description, code: err.code)
        } else {
            self.init(title: nil, description: e?.localizedDescription, code: 0)
        }
    }
    
    // HTTP Error
    public init(_ res: HTTPURLResponse?) {
        self.init(description: HTTPURLResponse.localizedString(forStatusCode: res?.statusCode ?? 0), code: res?.statusCode ?? 0)
    }
    
    // Moya Error
    public init(_ err: MoyaError?) {
        if let response = err?.response {
           do {
               if let jsonObject = try response.mapJSON(failsOnEmptyData: false) as? [String: Any] {
                   if let errorDict = jsonObject["error"] as? [String: Any],
                      let errorMessage = errorDict["message"] as? String {
                       let statusCode = jsonObject["statusCode"] as? Int ?? response.statusCode
                       self.init(description: errorMessage, code: statusCode)
                   } else {
                       self.init(description: LinkedOutError.emptyDesc, code: response.statusCode)
                   }
               }
           } catch {
               self.init(description: err?.localizedDescription ?? LinkedOutError.emptyDesc, code: 0)
           }
       }
        
        self.init(description: err?.localizedDescription, code: err?.errorCode ?? 0)
    }
    
    // Linkedout API Error
    public init(_ res: ApiWebResult?) {
        self.init(description: res?.message, code: res?.statusCode ?? 0)
    }
    
    // Others Error
    public init(title: String? = nil, description: String? = nil, code: Int) {
        self.title = title ?? LinkedOutError.emptyTitle
        self.description = description ?? LinkedOutError.emptyDesc
        self.code = code
    }
}

// MARK: - FoodinkoError: Equatable
extension LinkedOutError: Equatable {
    public static func ==(lhs: LinkedOutError, rhs: LinkedOutError) -> Bool {
        return (lhs.code == rhs.code) && (lhs.description == rhs.description)
    }
}

// MARK: - FoodinkoError: Custom
extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    public func catchApiErrorJustReturn() -> Single<Element> {
        return flatMap { response in
            let linkedoutWebResult = try response.map(ApiWebResult.self,
                                               atKeyPath: "",
                                               using: JSONDecoder().since1970(),
                                               failsOnEmptyData: false)
            
            // 비지니스 에러
            if linkedoutWebResult.success {
                return .just(response)
            } else {
                guard linkedoutWebResult.statusCode == 200 else {
                    do {
                        throw LinkedOutError(linkedoutWebResult)
                    }
                    catch {
                        throw error
                    }
                }
            }
                                    
            return .just(response)
        }
        .debug()
    }
}

extension JSONDecoder {
    func since1970() -> JSONDecoder {
        dateDecodingStrategy = .secondsSince1970
        return self
    }
}

