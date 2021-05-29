//
//  StatsViewController.swift
//  Pokedex
//
//  Created by Hasan Aygünoglu on 28.05.2021.
//

import UIKit

class StatsViewController: UIViewController {

    @IBOutlet weak var pokemonView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonView.layer.cornerRadius = 30

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
