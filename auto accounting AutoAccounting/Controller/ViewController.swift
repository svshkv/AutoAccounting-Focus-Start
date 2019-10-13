//
//  ViewController.swift
//  auto accounting AutoAccounting
//
//  Created by Саша Руцман on 09/10/2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var allCars: [Auto]?
    var selectedCar: Auto?
    let carVC = CarViewController()
    @IBOutlet weak var tableView: UITableView!
    let reuseIdentifier = "autoCell"
    var addButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsForFirstLaunch()
        allCars = Array(realm.objects(Auto.self))
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    private func settingsForFirstLaunch() {
        if UserDefaults.standard.isFirstLaunch() {
            let car1 = Auto(id: 1, year: "2019", model: "m5", body: "Sedan", manufacturer: "BMW", logo: 17)
            let car2 = Auto(id: 2, year: "2019", model: "rs6", body: "Universal", manufacturer: "Audi", logo: 12)
            let car3 = Auto(id: 3, year: "2019", model: "S63 AMG", body: "Coupe", manufacturer: "Mercedes", logo: 18)
            let cars = [car1, car2, car3]
        
            for car in cars {
                StorageManager.saveObject(autoObject: car)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //StorageManager.deleteAllObjects()
        allCars = Array(realm.objects(Auto.self))
        tableView.reloadData()
        
    }

    @objc func addButtonTapped() {
        
        selectedCar = nil
        performSegue(withIdentifier: "toCar", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCar" {
            if let carVC = segue.destination as? CarViewController {
                guard let selectedCar = selectedCar else { return }
                carVC.car = selectedCar
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCars?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CarTableViewCell
        guard let car = allCars?[indexPath.row] else { return  UITableViewCell() }
        cell.manufacturerLabel.text = car.manufacturer
        cell.modelLabel.text = car.model
        cell.yearLabel.text = car.year
        if car.logo != 100 {
            cell.logoImageView.clipsToBounds = true
            cell.logoImageView.image = StorageManager.logos[car.logo].withRenderingMode(.alwaysOriginal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCar = allCars?[indexPath.row]
        performSegue(withIdentifier: "toCar", sender: self)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            StorageManager.deleteObject(autoObject: allCars![indexPath.row])
            allCars?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

