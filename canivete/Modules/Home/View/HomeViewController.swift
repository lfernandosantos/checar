//
//  ViewController.swift
//  canivete
//
//  Created by Luiz Fernando dos Santos on 14/08/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let user = DatabaseService.shared.getUser()
        let urlImage = user!.profileImageURL!
        self.setProfilePicture(urlImage)
    }


    private func setProfilePicture(_ url: URL) {
        guard let navigationBar = self.navigationController?.navigationBar else { return }

        self.loagImage(url: url) { (image) in
            let button = UIButton(type: UIButton.ButtonType.custom)
            button.setImage(image, for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 30).isActive = true
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button.clipsToBounds = true
            button.layer.cornerRadius = 15
            let barButton = UIBarButtonItem(customView: button)
            
            let navigationItem = UINavigationItem()
            navigationItem.rightBarButtonItem = barButton
            navigationBar.setItems([navigationItem], animated: true)
//            self.navigationItem.rightBarButtonItems = [barButton]
        }
    }
    
    private func loagImage(url: URL, completion: @escaping (UIImage) -> Void){
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            guard let image = UIImage(data: data)?.withRenderingMode(.alwaysOriginal) else { return }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    @IBAction func addCar(_ sender: Any) {
//        FlowController.shared.openCar()
        
        let searchview = SearchViewController(nibName: "SearchViewController", bundle: nil)
        let nav = UINavigationController(rootViewController: searchview)
        nav.modalPresentationStyle = .fullScreen
        self.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
}

