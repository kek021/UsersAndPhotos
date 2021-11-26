//
//  Parser.swift
//  UsersAndPhotos
//
//  Created by Александр Жуков on 25.11.2021.
//

import Foundation

class Parser {
    
    let loader = Loader()
    
    func parseUsers(url: String, response: @escaping (Users?) -> Void){
        loader.getData(url: url) { (results) in
            switch results {
            case .success(let data):
                do{
                    let result = try JSONDecoder().decode(Users.self, from: data)
                    response(result)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    
    func parsePhotos(url: String, response: @escaping (Photos?) -> Void){
        loader.getData(url: url) { (results) in
            switch results {
            case .success(let data):
                do{
                    let result = try JSONDecoder().decode(Photos.self, from: data)
                    response(result)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}
