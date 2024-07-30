//
//  MoviesEndpoint.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import Foundation
import Alamofire

enum MoviesEndpoint {
    case popularMovies(page: Int)
    case movieDetails(movieID: Int)
}

extension MoviesEndpoint: Endpoint {
    var baseURL: URL {
        guard let url = URL(string: APIConstants.baseURL) else { fatalError("Base URL isn't valid.") }
        return url
    }
    
    var path: String {
        switch self {
        case .movieDetails(let movieID):
            return "/\(movieID)"
            
        case .popularMovies:
            return APIConstants.Paths.popularMoviesPath
        }
    }
    
    var parameters: Alamofire.Parameters? {
        var parameters: [String: Any] =  [
            "api_key": APIConstants.APIKey,
            "language": "en-US"
        ]
        
        switch self {
        case .popularMovies(let page):
            parameters["page"] = page
            
        default:
            break
        }
        
        return parameters
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .movieDetails, .popularMovies:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        return  [
            "accept": "application/json",
            "Connection": "keep-alive"
        ]
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .post:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
}