//
//  BaseViewController.swift
//  quiz_ios
//
//  Created by Jossue Betancourt on 14/03/22.
//

import UIKit
import Foundation
import SystemConfiguration


class BaseViewController: UIViewController{
    
      var alert = UIAlertController()
      var alert_indicator = UIAlertController()
      var activeField: UITextField?
      var scrollView_: UIScrollView?
      var indicator : UIActivityIndicatorView!
      var viewLoading : UIView!
      var view_container : UIView!
      var indicatorContainer: UIView = UIView()
      var loadingView: UIView = UIView()

       override func viewDidLoad() {
           super.viewDidLoad()
           
       }

    
    // MARK: Alerts
    func toast(message:String, title:String = "")->Void{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        if let popoverController = alert.popoverPresentationController {
          popoverController.sourceView = self.view
          popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
          popoverController.permittedArrowDirections = []
        }
        
        self.present(alert, animated: true, completion: nil)
        
        // change to desired number of seconds (in this case 3 seconds)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func showActivityIndicatory(uiView: UIView) {
          self.indicatorContainer.frame = uiView.frame
          self.indicatorContainer.center = uiView.center
          
          self.indicatorContainer.backgroundColor = UIColorFromHEX(rgbValue: 0xffffff, alpha: 0.0)
          
          self.loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
          self.loadingView.center = uiView.center
          self.loadingView.backgroundColor = UIColorFromHEX(rgbValue:0x444444, alpha: 0.7)
          self.loadingView.clipsToBounds = true
          self.loadingView.layer.cornerRadius = 10
          
          let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
          actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
          if #available(iOS 13.0, *) {
              actInd.style = UIActivityIndicatorView.Style.large
          } else {
              // Fallback on earlier versions
          }
          actInd.center = CGPoint(x: loadingView.frame.size.width / 2,
                                  y: loadingView.frame.size.height / 2);
          self.loadingView.addSubview(actInd)
          self.indicatorContainer.addSubview(loadingView)
          uiView.addSubview(indicatorContainer)
          actInd.startAnimating()
      }
      
      func hiddenActivityIndicatory(){
          self.indicatorContainer.removeFromSuperview()
      }
      
      func alert(_ title: String, message: String, okAction: UIAlertAction?, cancelAction: UIAlertAction?, automatic: Bool){
          alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
          if  okAction != nil{
              alert.addAction(okAction!)
          }
          if cancelAction != nil{
              alert.addAction(cancelAction!)
          }else{
            
            if  okAction == nil{
                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: { _ in
                      self.dismissAlert()
                  }))
            }
          }
          
          if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
          }
          
          self.present(alert, animated: true, completion: nil)
          if automatic == true{
              Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(BaseViewController.dismissAlert), userInfo: nil, repeats: false)
          }
      }
      
      @objc func dismissAlert(){
         alert.dismiss(animated: true, completion: nil)
      }
    
      func UIColorFromHEX(rgbValue: UInt, alpha: Float) -> UIColor {
           return UIColor(
               red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
               green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
               blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
               alpha: CGFloat(alpha)
           )
     }
    
    // guardar datos de persistentes -----------------------
      let defaults:UserDefaults = UserDefaults.standard
      
      func setSettings(key:String, value:String){
          defaults.set(value, forKey: key)
          defaults.synchronize()
      }
      
      func getSettings(key:String) -> String{
          if  let value = defaults.string(forKey: key) as? String {
              return value
          }
          return ""
      }
      
      //Gif Loading
    
      
      func showGifIndicator_ext(view: UIView){
          viewLoading = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
          viewLoading.backgroundColor = UIColor.black.withAlphaComponent(0.5)
          
          
          view_container = UIView(frame: CGRect(x: (self.view.frame.size.width/2) - 125, y: (self.view.frame.size.height/2) - 100, width: 250, height: 200))
          view_container.backgroundColor = UIColor.white.withAlphaComponent(1.0)
          
          
          let image: UIImageView!
          image = UIImageView(frame: CGRect(x: (view_container.frame.size.width/2) - 50, y: (view_container.frame.height/2)-80, width: 100, height: 100))
          image.layer.cornerRadius = 50
          image.layer.masksToBounds=true
          image.contentMode = .scaleAspectFill
          image.image = UIImage(named: "sucess_ask")
    
          let label = UILabel(frame: CGRect(x: 0, y: 125, width: self.view_container.frame.width, height: 40))
          label.text = "Guardado correctamente"
          label.font=UIFont.systemFont(ofSize: 15)
          label.textAlignment = .center
          label.lineBreakMode = .byWordWrapping
          label.numberOfLines = 2
          
          view_container.addSubview(image)
          view_container.addSubview(label)
          
          viewLoading.addSubview(view_container)
          view.addSubview(viewLoading)
      }
      
      func hiddenGifIndicator(view: UIView){
          if viewLoading != nil{
              viewLoading.removeFromSuperview()
              viewLoading = nil
          }
      }
    
    func empty_data_collection_view(component: UICollectionView, string: String? = "No se encontraron elementos.", color:String? = "000000"){
            let view: UIView     = UIView(frame: CGRect(x: 0, y: 0, width: 21, height: 21))
            let title: UILabel     = UILabel(frame: CGRect(x: 0, y:(component.frame.size.height/2), width: self.view.frame.width, height: 21))
            let noDataLabel: UIImageView     = UIImageView(frame: CGRect(x: (self.view.frame.width/2) - 30, y: (component.frame.height/2) - 65, width: 60, height: 60))
            title.text             = string
            title.textColor        = .black
            title.textAlignment    = .center
            //noDataLabel.image = UIImage(named: "ic_action_pais")
            view.addSubview(title)
            //view.addSubview(noDataLabel)
            
            view.backgroundColor = Colors.primaryDark
            component.backgroundView = view
            component.backgroundView?.isHidden = false
            //component.separatorStyle = .none
        }
    
    //Tabla Vacia
    func empty_data_tableview(tableView: UITableView, string: String? = "No se encontraron elementos.", color:String? = "000000"){
            let view: UIView     = UIView(frame: CGRect(x: 0, y: 0, width: 21, height: 21))
            let title: UILabel     = UILabel(frame: CGRect(x: 0, y:(tableView.frame.size.height/2), width: self.view.frame.width, height: 21))
            let noDataLabel: UIImageView     = UIImageView(frame: CGRect(x: (self.view.frame.width/2) - 30, y: (tableView.frame.height/2) - 65, width: 60, height: 60))
            title.text             = string
            title.textColor        = .black
            title.textAlignment    = .center
            //noDataLabel.image = UIImage(named: "ic_action_pais")
            view.addSubview(title)
            //view.addSubview(noDataLabel)
            
            view.backgroundColor = Colors.primaryDark
            tableView.backgroundView = view
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
        }
    
    func clear_empty_data_tableview(tableView: UITableView, separatorStyle: UITableViewCell.SeparatorStyle? = .singleLine, color: UIColor? = UIColor.gray){
      
        tableView.backgroundView = .none
        tableView.backgroundView?.isHidden = true
        tableView.separatorStyle = separatorStyle!
        tableView.separatorColor = color
    }

}

