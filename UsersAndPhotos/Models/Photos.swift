//
//  Photos.swift
//  UsersAndPhotos
//
//  Created by Александр Жуков on 25.11.2021.
//

import Foundation

typealias Photos = [PhotosFormatted]

struct PhotosFormatted: Codable {
    let title: String
    let url: String
}
