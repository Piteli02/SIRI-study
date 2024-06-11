//
//  GitHubUser.swift
//  SiriAndAPI
//
//  Created by Caio Gomes Piteli on 11/06/24.
//

import Foundation

struct GitHubUser: Decodable{
    let login: String
    let avatarUrl: String
    let publicRepos: Int
    let followers: Int
}
