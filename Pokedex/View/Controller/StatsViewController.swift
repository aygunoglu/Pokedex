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
    
    var getURL = String()
    var getName = String()
    
    private var statsViewModel = StatsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonView.layer.cornerRadius = 30
        statsViewModel.delegate = self
        statsViewModel.callFuncToGetStatsData(url: getURL)

    }
    
}

extension StatsViewController: PokemonStatsDelegate {
    func didParseJSON(pokemonModel: PokemonStatsModel) {
        DispatchQueue.main.async {
            self.typeLabel.text = pokemonModel.type.capitalized
            self.nameLabel.text = self.getName.capitalized
            self.attackLabel.text = String(pokemonModel.attack)
            self.defenceLabel.text = String(pokemonModel.defence)
            self.healthLabel.text = String(pokemonModel.health)
            self.specialAttackLabel.text = String(pokemonModel.SPAttack)
            self.specialDefenceLabel.text = String(pokemonModel.SPDefence)
            self.speedLabel.text = String(pokemonModel.speed)
            let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonModel.id).png")
            self.pokemonImage.kf.setImage(with: url)
        }
    }
}
