//
//  Service.swift
//  MitchHolmesSynchronousPosterGetter
//
//  Created by Mitchell Holmes on 2019/02/20.
//  Copyright © 2019 Mitchell Holmes. All rights reserved.
//
import Foundation

public class TweetService {
    public init () {
        
    }
    public struct Tweet: Codable {
        public var userId: Int
        public var id: Int
        public var title: String
        public var body: String
        public init() {
            self.userId = 0
            self.id = 0
            self.title = ""
            self.body = ""
    }
    }
    public struct User: Codable {
        public var id: Int
        public var name: String
        public var surname: String
        public init() {
            self.id = 0
            self.name = ""
            self.surname = ""
        }
    }
    public static func getTweet(url: String, paramaters: [String: String]) -> [Tweet] {
        var tweet = [Tweet()]
        let urlWithParams = url + "/posts?userId=\(paramaters["userId"]!)&id=\(paramaters["tweetId"]!)"
        let url = URL(string: urlWithParams)!
        let semaphore = DispatchSemaphore(value: 0)
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            let response = response as! HTTPURLResponse
            if response.statusCode >= 200 && response.statusCode <= 299 {
                do {
                    let decoder = JSONDecoder()
                    tweet = try decoder.decode([Tweet].self, from: data!)
                    semaphore.signal()
                } catch let jsonError {
                    semaphore.signal()
                    print("Error in finding Tweet: ", jsonError)
                }
            } else {
                semaphore.signal()
            }
            }.resume()
        semaphore.wait()
        return tweet
    }
    public static func postUser(url: String, body: [String: String]) -> User {
        var user = User()
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let semaphore = DispatchSemaphore(value: 0)
        do {
            let encoder = JSONEncoder()
            let httpBody = try encoder.encode(body)
            request.httpBody = httpBody
        } catch let error {
            print("Error in posting Tweet: ", error)
        }
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            let response = response as! HTTPURLResponse
            if response.statusCode >= 200 && response.statusCode <= 299 {
                do {
                    let decoder = JSONDecoder()
                    user = try decoder.decode(User.self, from: data!)
                    semaphore.signal()
                } catch let jsonError {
                    semaphore.signal()
                    print("Error posting user: ", jsonError)
                }
            }
            else{
                semaphore.signal()
            }
        }.resume()
        semaphore.wait()
        return user
    }
}
