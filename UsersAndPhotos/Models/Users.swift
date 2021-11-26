//
//  Users.swift
//  UsersAndPhotos
//
//  Created by Александр Жуков on 25.11.2021.
//

import Foundation

typealias Users = [UsersFormatted]

struct UsersFormatted: Codable {
    let id: Int
    let name: String
}
