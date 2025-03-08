//
//  NetworkError.swift
//  Network
//
//  Created by Tiago Silva on 08/03/2025.
//

enum NetworkError: Error {
    case noData
    case urlBuildFail
    case redirection
    case client
    case server
}
