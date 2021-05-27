//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by Hasan Aygünoglu on 27.05.2021.
//

import Foundation

protocol PokedexViewModelDelegate: AnyObject {
    func refreshCollectionView()
}

final class PokedexViewModel {
    
    var page = 0
    weak var delegate: PokedexViewModelDelegate?
    var pokemons = [Pokemon]()
    
    func fetchPokemon(page: Int) {
        Service.shared.fetchPokemon(page: page) { (pokemons) in
            self.pokemons = pokemons
            self.delegate?.refreshCollectionView()
        }
    }
    
}
