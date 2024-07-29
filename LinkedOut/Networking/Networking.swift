//
//  Networking.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import Foundation
import Moya
import MoyaSugar
import RxSwift

public typealias LinkedOutNetworking = Networking<LinkedOutAPI>

// MARK: - Formatter
private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String()
    } catch {
        return String()
    }
}

// MARK: - Plugin
public let loggerPlugin: NetworkLoggerPlugin = {
    let plgn = NetworkLoggerPlugin()
    plgn.configuration.logOptions = .verbose
    plgn.configuration.formatter.responseData = JSONResponseDataFormatter
    return plgn
}()

// MARK: - Networking
public class Networking<Target: SugarTargetType>: MoyaSugarProvider<Target> {
    
    //public init() {}
    
    public init(plugins: [PluginType] = [loggerPlugin],
                endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
                stubClosure: @escaping StubClosure = MoyaProvider.immediatelyStub) {
        
        let session = MoyaProvider<Target>.defaultAlamofireSession()
        
        /// FIXME timeout property not working, 값을 넣어도 60.0으로 변함 없음
        // Timeout
        session.session.configuration.timeoutIntervalForRequest = 15
        session.session.configuration.timeoutIntervalForResource = 15
        session.sessionConfiguration.timeoutIntervalForRequest = 15
        session.sessionConfiguration.timeoutIntervalForResource = 15
        
        #if DEBUG
            //for API
            super.init(session: session, plugins: plugins)
        
            //for Stub
//            super.init(endpointClosure: endpointClosure, stubClosure: stubClosure, session: session, plugins: plugins)
        #elseif RELEASE
            //for API
            super.init(session: session, plugins: plugins)
        #elseif TESTS
            //for Stub
            super.init(endpointClosure: endpointClosure, stubClosure: stubClosure, session: session, plugins: plugins)
        #endif
        
    }
    
}


extension Networking {

    public func request(_ target: Target,
                        file: StaticString = #file,
                        function: StaticString = #function,
                        line: UInt = #line) -> Single<Response> {
        
        let requestString = "\(target.method.rawValue) \(target.path)"
        
        return self.rx.request(target)
            .filterSuccessfulStatusCodes()
            .catchApiErrorJustReturn()
            .do(onSuccess: { value in
                let message = "SUCCESS: \(requestString) (\(value.statusCode))"
                log.debug(message, file: file, function: function, line: line)
            },
                onError: { error in
                    if let response = (error as? MoyaError)?.response {
                        if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                            let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(jsonObject)"
                            log.warning(message, file: file, function: function, line: line)
                        } else if let rawString = String(data: response.data, encoding: .utf8) {
                            let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
                            log.warning(message, file: file, function: function, line: line)
                        } else {
                            let message = "FAILURE: \(requestString) (\(response.statusCode))"
                            log.warning(message, file: file, function: function, line: line)
                        }
                    } else {
                        let message = "FAILURE: \(requestString)\n\(error)"
                        log.warning(message, file: file, function: function, line: line)
                    }
            },
                onSubscribed: {
                    let message = "REQUEST: \(requestString)"
                    log.debug(message, file: file, function: function, line: line)
            })
            .debug()
    }

}

