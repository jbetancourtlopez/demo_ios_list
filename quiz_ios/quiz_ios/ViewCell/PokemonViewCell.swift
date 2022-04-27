//
//  PokemonViewCell.swift
//  quiz_ios
//
//  Created by Jossue Betancourt on 14/03/22.
//

import Foundation
import UIKit


class PokemonViewCell: UITableViewCell{
 
    @IBOutlet var name: UILabel!
    @IBOutlet var url: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
