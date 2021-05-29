//
//  Service.swift
//  Pokedex
//
//  Created by Hasan Aygünoglu on 27.05.2021.
//

import Foundation

class Service {
    static let shared = Service()
    var pokemonArray = [Pokemon]()
    
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
    
    func fetchPokemonDetails() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Failed to fetch data with error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            var result: PokemonDetails?
            do {
                result = try JSONDecoder().decode(PokemonDetails.self, from: data)
            }
            catch {
                print("error")
            }
            
            guard let pokemonDetails = result else { return }
            
            print(result!.stats[0].baseStat)
            print(result!.stats[1].baseStat)
            
        }.resume()
        
    }
    
}
