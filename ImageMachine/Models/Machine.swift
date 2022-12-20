//
//  Machine.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 20/12/22.
//

import Foundation

struct Machine: Codable {
    let id: Int
    let name: String
    let type: String
    let lastUpdated: Date
    let codeNumber: Int
}
