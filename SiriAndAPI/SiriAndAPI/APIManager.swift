//
//  APIManager.swift
//  SiriAndAPI
//
//  Created by Caio Gomes Piteli on 11/06/24.
//

import Foundation


enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

class APIManager{
    
    func getUser(userName: String) async throws -> GitHubUser{
        let endpointBase = "https://api.github.com/users/" //Creating endpoint base
        let endpoint = endpointBase + userName //Adding the username that came from the view on the endpoint
        
        // MARK: - Transforming endpoint to URl
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        
        // MARK: - Creating my "get" request
        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        
        // MARK: - If the response of the URL isn't 200, means something went wrong
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else{
            throw GHError.invalidResponse
        }
        
        // MARK: - Decoding data received to the GitHubUser type
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        } catch{
            throw GHError.invalidData //90% of the time, this will fail because my struct (GitHubUser) may be different from the json received
        }
    }
}


