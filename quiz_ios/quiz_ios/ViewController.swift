//
//  ViewController.swift
//  quiz_ios
//
//  Created by Jossue Betancourt on 14/03/22.
//

import UIKit
import Kingfisher


class ViewController: BaseViewController {

    let service =  GeneralService()
    var lst_pokemon: Array<Pokemon> = []
    
    // UI
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup_ui()
        load_data(search: "")
    }
    
    func setup_ui(){
        title = "Quiz iOS"
        tableview.delegate = self
        tableview.dataSource = self
        searchBar.delegate = self
    }
    
    func load_data(search: String){
        
        self.showActivityIndicatory(uiView: self.view)
        
        var parameter: [String : Any] = [:]
        if(search != ""){
            parameter["search"] = search
        }
            
        service.pokemon(parameters:parameter ){ (status: Int, response : Array<Pokemon>? , msg: String) -> () in
           
            self.hiddenActivityIndicatory()
            
           if status == 200 {
                self.lst_pokemon = response!
                if self.lst_pokemon.count == 0 {
                    self.empty_data_tableview(tableView: self.tableview)
                }
                
                self.tableview.reloadData()
           }else{
                self.toast(message: "Ocurrio un Error")
           }
        }
    }
}

// SearchBar

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            let search = searchText.lowercased()
            print(search)
        self.load_data(search: search)
       }
       
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           searchBar.resignFirstResponder() // hides the keyboard.
       }
}
//table view
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lst_pokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "Cell") as! PokemonViewCell
        let item = lst_pokemon[indexPath.row]
       
        cell.name.text = item.name
        
        var url_image = "https://mobile-developer.jossuebetancourt.com/application/views/img/logo_jb_redondo.png"
        
        let url = URL(string: url_image)

        KF.url(url).set(to: cell.icon)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = lst_pokemon[indexPath.row]
        
        // Cambio de Screen
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.url = item.url
        vc.name = item.name
        self.show(vc, sender: nil)
     
    }
}
