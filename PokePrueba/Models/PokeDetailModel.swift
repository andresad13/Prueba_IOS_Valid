//
//  PokeDetailModel.swift
//  PokePrueba
//
//  Created by Mac mini on 25/02/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

import UIKit

class PokeDetailModel {
     var id: Int?
     var name: String?
     var weight : Int?
     var height : Int?
    var stats : [PokeStats]
    var types : [PokeTypes]
    
    init(id: Int?, name: String?, weight: Int?, height: Int?, stats: [PokeStats], types: [PokeTypes]){
        self.name = name
        self.id = id
        self.weight = weight
        self.height = height
        self.stats = stats
        self.types = types

    }

}
