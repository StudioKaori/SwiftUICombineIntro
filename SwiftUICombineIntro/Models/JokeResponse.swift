//
//  JokeResponse.swift
//  SwiftUICombineIntro
//
//  Created by Kaori Persson on 2022-06-10.
//

import Foundation

struct JokeResponse: Codable {
    var id: String
    var joke: String
    var status: Int
}
