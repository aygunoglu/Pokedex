//
//  StatsViewModel.swift
//  Pokedex
//
//  Created by Hasan Aygünoglu on 1.06.2021.
//

import Foundation

protocol PokemonStatsDelegate {
    func didParseJSON(pokemonModel: PokemonStatsModel)
}

class StatsViewModel : NSObject {
    
    var statsData : PokemonStats!
    var statsModel : PokemonStatsModel!
    var delegate : PokemonStatsDelegate?
    
    func callFuncToGetStatsData(url: String) {
        Service.shared.fetchPokemonStats(url: url) { statsData in
            self.statsData = statsData
            self.statsModel = PokemonStatsModel(height: self.statsData.height, weight: self.statsData.weight, type: self.statsData.types[0].type.name, health: self.statsData.stats[0].baseStat, attack: self.statsData.stats[1].baseStat, defence: self.statsData.stats[2].baseStat, SPAttack: self.statsData.stats[3].baseStat, SPDefence: self.statsData.stats[4].baseStat, speed: self.statsData.stats[5].baseStat, id: self.statsData.id)
            
            if let finalStatsModel = self.statsModel {
                self.delegate?.didParseJSON(pokemonModel: finalStatsModel)
            }
        }
    }
    
}
