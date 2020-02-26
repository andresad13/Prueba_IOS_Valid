//
//  Services.swift
//  PokePrueba
//
//  Created by Mac mini on 26/02/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Services {
    
    func getPokes(completionHandler: @escaping ([Pokes]) -> ()) {
        var PokeArray :  [Pokes] = [Pokes]()
        let base_url = NSLocalizedString ("base_url", comment: "")
        let poke_url = NSLocalizedString ("pokes_url", comment: "")
        AF.request("\(base_url)\(poke_url)", method:.get , parameters : nil ,encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                DispatchQueue.main.async {}
                if let json = response.data {
                    do{
                        let data = try JSON(data: json)
                        let str = data["results"]
                        for (_, subJson) in str {
                            let pokeTemp : Pokes = Pokes(name: subJson["name"].string!, url: subJson["url"].string!)
                            PokeArray.append(pokeTemp)
                        }
                        completionHandler(PokeArray)
                    }
                    catch{
                        print("JSON Error")
                    }
                }
        }
    }
    
    
    func getPoke(completionHandler: @escaping (PokeDetailModel) -> ()) {
        AF.request(UserDefaults.standard.string(forKey: "selectedPoke")!, method:.get , parameters : nil ,encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                DispatchQueue.main.async {}
                if let json = response.data {
                    do{
                        let data = try JSON(data: json)
                        let name = data["name"]
                        let id = data["id"]
                        let weight = data["weight"]
                        let height = data["height"]
                        let stats = data["stats"]
                        let types = data["types"]
                        var pokestats : [PokeStats] = [PokeStats]()
                        for (_, subJson) in stats {
                            let statsTemp : PokeStats = PokeStats(name: subJson["stat"]["name"].string, base_stat: subJson["base_stat"].int)
                            pokestats.append(statsTemp)
                        }
                        var pokestypes : [PokeTypes] = [PokeTypes]()
                        for (_, subJson) in types {
                            let typesTemp : PokeTypes = PokeTypes(name: subJson["type"]["name"].string)
                            pokestypes.append(typesTemp)
                        }
                        let pokeSelected : PokeDetailModel = PokeDetailModel(id: id.int, name: name.string, weight: weight.int, height: height.int, stats: pokestats, types: pokestypes)
                        completionHandler(pokeSelected)
                    }
                    catch{
                        print("JSON Error")
                        
                    }
                }
        }
    }
}
