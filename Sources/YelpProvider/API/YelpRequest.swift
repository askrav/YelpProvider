//
//  YelpRequest.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/21/19.
//

import Vapor
import HTTP

public protocol YelpRequest: class {
    func send<YM: YelpModel>(method: HTTPMethod, path: String, query: String, body: LosslessHTTPBodyRepresentable, headers: HTTPHeaders) throws -> Future<YM>
    func serializedResponse<YM: YelpModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<YM>
}

public extension YelpRequest {
    
    public func send<YM: YelpModel>(method: HTTPMethod, path: String, query: String = "",
                                    body: LosslessHTTPBodyRepresentable = HTTPBody(string: ""),
                                    headers: HTTPHeaders = [:]) throws -> Future<YM> {
        return try send(method: method, path: path, query: query, body: body, headers: headers)
    }
    
    public func serializedResponse<YM: YelpModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<YM> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        guard response.status == .ok else {
            return try decoder.decode(YelpError.self, from: response, maxSize: 65_536, on: worker).map(to: YM.self){ error in
                throw error
            }
        }
        
        return try decoder.decode(YM.self, from: response, maxSize: 65_536, on: worker)
    }
}

extension HTTPHeaders {
    public static var yelpDefault: HTTPHeaders {
        var headers: HTTPHeaders = [:]
        headers.replaceOrAdd(name: .contentType, value: "application/json")
        return headers
    }
}

public class YelpAPIRequest: YelpRequest {
    private let httpClient: Client
    private let apiKey: String
    
    init(httpClient: Client, apiKey: String) {
        self.httpClient = httpClient
        self.apiKey = apiKey
    }
    
    public func send<YM: YelpModel>(method: HTTPMethod, path: String, query: String,
                                    body: LosslessHTTPBodyRepresentable, headers: HTTPHeaders) throws -> Future<YM> {
        var finalHeaders: HTTPHeaders = .yelpDefault
        
        finalHeaders.add(name: .authorization, value: "Bearer \(apiKey)")
        headers.forEach { finalHeaders.replaceOrAdd(name: $0.name, value: $0.value) }
        
        return httpClient.send(method, headers: finalHeaders, to: "\(path)?\(query)") { (request) in
            request.http.body = body.convertToHTTPBody()
            }.flatMap(to: YM.self) { (response) -> Future<YM> in
                return try self.serializedResponse(response: response.http, worker: self.httpClient.container.eventLoop)
        }
    }
}
