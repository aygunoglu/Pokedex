//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Hasan Aygünoglu on 27.05.2021.
//

import UIKit
import Kingfisher

class PokemonCell: UICollectionViewCell {
    @IBOutlet weak var pokemonThumb: UIImageView!
    @IBOutlet weak var pokemonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10.0
    }

    func configure(with model: Pokemon, cellID: Int) {
        self.pokemonLabel.text = model.name.capitalized
        
        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(cellID).png")
        pokemonThumb.kf.setImage(with: url)
    }
    
    
}
