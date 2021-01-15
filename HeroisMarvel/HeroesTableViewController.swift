//
//  HeroesTableViewController.swift
//  HeroisMarvel
//
//  Created by Eric Brito on 22/10/17.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class HeroesTableViewController: UITableViewController {

    private var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var name: String?
    private var heroes: [Hero] = []
    private var loadingHerores = false
    private var currentPage = 0
    private var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Buscando heróis aguade..."
        loadHeroes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = heroes.count == 0 ? label : nil
        return heroes.count
    }

    private func loadHeroes() {
        loadingHerores = true
        MarvelAPI().loadHeroes(name: name, page: currentPage) { (info) in
            if let info = info {
                self.heroes += info.data.results
                self.total = info.data.total
                
                print("Total: \(self.total) incluídos: \(self.heroes.count)")
            }
            
            self.reloadData()
        }
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.loadingHerores = false
            self.label.text = "Sem resultados para o nome: \(self.name ?? "")"
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeroTableViewCell

        cell.prepareCell(with: heroes[indexPath.row])

        return cell
    }
}
