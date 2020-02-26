//
//  ViewController.swift
//  PokePrueba
//
//  Created by Mac mini on 25/02/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON




class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PokeViewCell
        cell.pokeName.text = pokeList[indexPath.row].name
        cell.pokeImg.image = UIImage(named: pokeList[indexPath.row].name!)
        let numPoke = pokeList[indexPath.row].url!.index(pokeList[indexPath.row].url!.startIndex, offsetBy: pokeList[indexPath.row].url!.count - 2)
        
        cell.numberPoke.text = " \(NSLocalizedString ("poke_number", comment: "")) \( String(pokeList[indexPath.row].url![numPoke]))"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        UserDefaults.standard.set(pokeList[indexPath.row].url!, forKey: "selectedPoke") //setObject
        self.performSegue(withIdentifier: "toDetail", sender: self)
        
        
        
        
    }
    
    @IBOutlet weak var pokeSearch: UISearchBar!
    var pokeList : [Pokes] = []
    var pokeListGeneral : [Pokes] = []
    
    @IBOutlet weak var collectionpoke: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearch.showsScopeBar = true
        pokeSearch.delegate = self
        Services().getPokes(){ (success) in
            self.pokeList = success
            self.pokeListGeneral = success
            self.collectionpoke.reloadData()
            
        }
        
    }
    
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        let textFind =  searchBar.text!
        pokeList.removeAll()
        for index in pokeListGeneral{
            if index.name!.contains(textFind) {
                pokeList.append(index)
            }
        }
        if(textFind == "")  {
            pokeList = pokeListGeneral
        }
        self.collectionpoke.reloadData()
        
    }
 
}

