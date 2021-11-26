//
//  Loader.swift
//  UsersAndPhotos
//
//  Created by Александр Жуков on 25.11.2021.
//

import Foundation

let listUrl = "https://jsonplaceholder.typicode.com/users"

func imagesUrl(userID: Int) -> String{
    return "https://jsonplaceholder.typicode.com/albums/\(userID)/photos"
}

class Loader {
    

    func getData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: url) {
            URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                    }
                    if let data = data {
                        completion(.success(data))
                    }
                }
            }.resume()
        }
    }
}
