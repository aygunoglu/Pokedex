//
//  Service.swift
//  Pokedex
//
//  Created by Hasan Aygünoglu on 27.05.2021.
//

import Foundation

protocol PokemonDetailsDelegate {
    func didParseJSON(pokemonStats: PokemonStatsModel)
}

class Service {
    static let shared = Service()
    var pokemonArray = [Pokemon]()
    var pokemonStats: PokemonStatsModel?
    var delegate: PokemonDetailsDelegate?
    
    
    func fetchPokemon(page: Int, completion: @escaping ([Pokemon]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=\(page)&;amp;limit=48") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Failed to fetch data with error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            var result: PokemonModel?
            do {
                result = try JSONDecoder().decode(PokemonModel.self, from: data)
            }
            catch {
                print("error")
            }
            
            guard let finalResult = result else { return }
            
            let newPokemons = finalResult.results
            self.pokemonArray.append(contentsOf: newPokemons)
            completion(self.pokemonArray)
            
        }.resume()
        
    }
    
    func fetchPokemonDetails(url: String) {
        
        if let url = URL(string: url) {
        
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    print("Failed to fetch data with error: ", error.localizedDescription)
                    return
                }
                
                guard let data = data else { return }
                
                var result: PokemonStats?
                do {
                    result = try JSONDecoder().decode(PokemonStats.self, from: data)
                }
                catch {
                    print("error")
                }
                
                guard let finalResult = result else { return }
                
                self.pokemonStats = PokemonStatsModel(height: finalResult.height, weight: finalResult.weight, type: finalResult.types[0].type.name, health: finalResult.stats[0].baseStat, attack: finalResult.stats[1].baseStat, defence: finalResult.stats[2].baseStat, SPAttack: finalResult.stats[3].baseStat, SPDefence: finalResult.stats[4].baseStat, speed: finalResult.stats[5].baseStat, id: finalResult.id)
                self.delegate?.didParseJSON(pokemonStats: self.pokemonStats!)
                
            }.resume()
        }
    }
    
}
