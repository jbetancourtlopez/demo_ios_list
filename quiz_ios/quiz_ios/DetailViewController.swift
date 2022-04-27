//
//  DetailViewController.swift
//  quiz_ios
//
//  Created by Jossue Betancourt on 14/03/22.
//

import Foundation
import UIKit
import Kingfisher


class DetailViewController: BaseViewController {

    let service =  GeneralService()
    var model: Pokemon? = nil
    var url: String = ""
    var name: String = ""
    
    // UI
    @IBOutlet var label_name: UILabel!

    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup_ui()
        load_data()
    }
    
    func setup_ui(){
        title = "Quiz Detail iOS"
    }
    
    func load_data(){
        label_name.text = name
        
        
//        self.showActivityIndicatory(uiView: self.view)
//
//        var parameter: [String : Any] = [:]
//
//        service.pokemon(parameters:parameter ){ (status: Int, response : Array<Pokemon>? , msg: String) -> () in
//
//            self.hiddenActivityIndicatory()
//
//           if status == 200 {
//                self.lst_pokemon = response!
//                if self.lst_pokemon.count == 0 {
//                    self.empty_data_tableview(tableView: self.tableview)
//                }
//
//                self.tableview.reloadData()
//           }else{
//                self.toast(message: "Ocurrio un Error")
//           }
//        }
    }
}

