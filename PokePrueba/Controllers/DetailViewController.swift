//
//  DetailViewController.swift
//  PokePrueba
//
//  Created by Mac mini on 25/02/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return typeArray.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PokeCollectionViewCell
    cell.textoTipo.text = typeArray[indexPath.row].name
    return cell
}

@IBOutlet weak var pokeAltura: UILabel!
@IBOutlet weak var pokePeso: UILabel!
@IBOutlet weak var pokeName: UILabel!
@IBOutlet weak var pokeImg: UIImageView!
@IBOutlet weak var coleccionTypes: UICollectionView!
@IBOutlet weak var cornerView: UIView!
var typeArray : [PokeTypes] = []
@IBOutlet weak var stat1: UILabel!
@IBOutlet weak var stat2: UILabel!
@IBOutlet weak var stat3: UILabel!
@IBOutlet weak var stat4: UILabel!
@IBOutlet weak var stat5: UILabel!
@IBOutlet weak var stat6: UILabel!
@IBOutlet weak var progress1: UIProgressView!
@IBOutlet weak var progress2: UIProgressView!
@IBOutlet weak var progress3: UIProgressView!
@IBOutlet weak var progress4: UIProgressView!
@IBOutlet weak var progress5: UIProgressView!
@IBOutlet weak var progress6: UIProgressView!



override func viewDidLoad() {
    super.viewDidLoad()
    cornerView.layer.cornerRadius = 100
    cornerView.layer.masksToBounds = true
    cornerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    Services().getPoke(){ (success) in
        print(success.name!)
        self.pokePeso.text  = "\(NSLocalizedString ("poke_weight", comment: "")) \(success.weight!)"
        self.pokeAltura.text  = "\(NSLocalizedString ("poke_height", comment: ""))  \(success.height!)"
        self.pokeImg.image = UIImage(named: success.name!)
        self.pokeName.text = success.name!
        self.typeArray = success.types
        self.stat1.text = success.stats[0].name
        self.stat2.text = success.stats[1].name
        self.stat3.text = success.stats[2].name
        self.stat4.text = success.stats[3].name
        self.stat5.text = success.stats[4].name
        self.stat6.text = success.stats[5].name
        self.progress1.progress = (Float(success.stats[0].base_stat!) / (Float(100)))
        self.progress2.progress = (Float(success.stats[1].base_stat!) / (Float(100)))
        self.progress3.progress = (Float(success.stats[2].base_stat!) / (Float(100)))
        self.progress4.progress = (Float(success.stats[3].base_stat!) / (Float(100)))
        self.progress5.progress = (Float(success.stats[4].base_stat!) / (Float(100)))
        self.progress6.progress = (Float(success.stats[5].base_stat!) / (Float(100)))
        self.coleccionTypes.reloadData()
    }
}
}
