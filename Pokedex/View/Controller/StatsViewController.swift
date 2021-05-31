//
//  StatsViewController.swift
//  Pokedex
//
//  Created by Hasan Aygünoglu on 28.05.2021.
//

import UIKit
import Kingfisher



class StatsViewController: UIViewController {

    @IBOutlet weak var pokemonView: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var specialAttackLabel: UILabel!
    @IBOutlet weak var defenceLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var specialDefenceLabel: UILabel!
    
    //var pokemonDetails: PokemonDetails?
    
    var getURL = String()
    var getName = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonView.layer.cornerRadius = 30
        
        Service.shared.delegate = self
        
        Service.shared.fetchPokemonDetails(url: getURL)


    }
    
}

extension StatsViewController: PokemonDetailsDelegate {
    func didParseJSON(pokemonStats: PokemonStatsModel) {
        DispatchQueue.main.async {
            self.typeLabel.text = pokemonStats.type.capitalized
            self.nameLabel.text = self.getName.capitalized
            self.attackLabel.text = String(pokemonStats.attack)
            self.defenceLabel.text = String(pokemonStats.defence)
            self.healthLabel.text = String(pokemonStats.health)
            self.specialAttackLabel.text = String(pokemonStats.SPAttack)
            self.specialDefenceLabel.text = String(pokemonStats.SPDefence)
            self.speedLabel.text = String(pokemonStats.speed)
            
            let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonStats.id).png")
            self.pokemonImage.kf.setImage(with: url)
        }
    }
}
