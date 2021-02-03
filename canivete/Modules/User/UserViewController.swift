//
//  UserViewController.swift
//  canivete
//
//  Created by Fernando on 27/09/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let profileDataSource: ProfileCollectionDataSource = ProfileCollectionDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = profileDataSource
        collectionView.dataSource = profileDataSource
        
        
    }

}
