//
//  LogosViewController.swift
//  auto accounting AutoAccounting
//
//  Created by Саша Руцман on 13/10/2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import UIKit

class LogosViewController: UIViewController {

    private let reuseIdentifier = "logoCell"
    var selectedLogo = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToCar" {
            if let carVC = segue.destination as? CarViewController {
                carVC.selectedLogo = selectedLogo
            }
        }
    }
    
}

extension LogosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StorageManager.logos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LogoCollectionViewCell
        cell.logoImageView.image = StorageManager.logos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedLogo = indexPath.row
        performSegue(withIdentifier: "backToCar", sender: nil)
    }
    
    
}
