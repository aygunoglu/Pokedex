//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Hasan Aygünoglu on 27.05.2021.
//

import Foundation

struct PokemonStats: Codable {
    let abilities: [AbilityElement]
    let height: Int
    let stats: [Stat]
    let types: [TypeElement]
    let weight: Int
    let id: Int
}

// MARK: - AbilityElement
struct AbilityElement: Codable {
    let ability: StatClass
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - StatClass
struct StatClass: Codable {
    let name: String
    let url: String
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int
    let stat: StatClass

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: StatClass
}
