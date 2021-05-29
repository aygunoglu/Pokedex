//
//  ViewController.swift
//  Pokedex
//
//  Created by Hasan Aygünoglu on 26.05.2021.
//

import UIKit

class PokedexViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let pokedexViewModel = PokedexViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokedexViewModel.fetchPokemon(page: pokedexViewModel.page)
        Service.shared.fetchPokemonDetails()
        pokedexViewModel.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellWithReuseIdentifier: "PokemonCell")
    }
    
}


extension PokedexViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokedexViewModel.pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        cell.configure(with: pokedexViewModel.pokemons[indexPath.row], cellID: indexPath.row + 1)
        return cell
    }
    
}

extension PokedexViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 36) / 3
        return CGSize(width: width, height: width)
    }
    
    
}

extension PokedexViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            pokedexViewModel.page += 48
            if pokedexViewModel.page < 864 {
                pokedexViewModel.fetchPokemon(page: pokedexViewModel.page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = Storyboard.instantiateViewController(identifier: "StatsViewController") as! StatsViewController
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
}

extension PokedexViewController: PokedexViewModelDelegate {
    func refreshCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

