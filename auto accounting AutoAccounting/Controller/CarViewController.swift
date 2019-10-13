//
//  CarViewController.swift
//  auto accounting AutoAccounting
//
//  Created by Саша Руцман on 10/10/2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import UIKit

class CarViewController: UIViewController  {

    private var allCellsTextField = [UITextField]()
    var selectedLogo = 100
    var car: Auto?
    private let reuseIdentifier = "settingsCell"
    private let placeholders = ["Марка", "Модель", "Кузов", "Год"]
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if car != nil && car?.logo != 100 {
            imageView.image = StorageManager.logos[(car?.logo)!]
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if selectedLogo != 100 {
            imageView.image = StorageManager.logos[selectedLogo]
        }
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard let manufacturer = allCellsTextField[0].text, let model = allCellsTextField[1].text,let body = allCellsTextField[2].text, let year = allCellsTextField[3].text else { return }
        if car == nil {
            var maxId = realm.objects(Auto.self).map{$0.id}.max() ?? 0
            maxId = maxId + 1
    
            if selectedLogo == 100 {
                let newCar = Auto(id: maxId, year: year, model: model, body: body, manufacturer: manufacturer)
                StorageManager.saveObject(autoObject: newCar)
            } else {
                let newCar = Auto(id: maxId, year: year, model: model, body: body, manufacturer: manufacturer, logo: selectedLogo)
                StorageManager.saveObject(autoObject: newCar)
            }
            
            navigationController?.popViewController(animated: true)
        } else {
            guard let updatedCar = realm.objects(Auto.self).filter("id == \(car!.id)").first else { return }
            try! realm.write {
                updatedCar.manufacturer = manufacturer
                updatedCar.model = model
                updatedCar.body = body
                updatedCar.year = year
                if selectedLogo != 100 {
                    updatedCar.logo = selectedLogo
                }
            }
            navigationController?.popViewController(animated: true)

        }
    }
    
    @objc private func imageViewTapped() {
        performSegue(withIdentifier: "toLogo", sender: nil)
    }
    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
    }

}

extension CarViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DetailsCarTableViewCell
        let placeholder = placeholders[indexPath.row]
        cell.detailTextField.placeholder = placeholder
        allCellsTextField.append(cell.detailTextField)

        if car != nil {
            switch indexPath.row {
            case 0:
                cell.detailTextField.text = car!.manufacturer
            case 1:
                cell.detailTextField.text = car!.model
            case 2:
                cell.detailTextField.text = car!.body
            case 3:
                cell.detailTextField.text = car!.year
            default:
                print("default")
            }
        }
        
        return cell
    }
    
    
    
}

