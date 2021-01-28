//
//  ProductTableViewController.swift
//  alisverisSepetim

import UIKit
import SCLAlertView

class ProductTableViewController: UITableViewController {
    let dataBase = DataBase()
    var array:[Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataBase.databaseConnection()
        array = dataBase.productList()
        
      //  navigationItem.backButtonTitle = "Geri"
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(addTapped))
        
        tableView.rowHeight = 150
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productDetail", for: indexPath) as! ProductCell
        let item = array[indexPath.row]
        cell.productTitle.text = item.title
        cell.productDetail.text = item.detail
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = UIContextualAction(style: .destructive, title: "Tamamlandı") {  (contextualAction, view, boolValue) in
            let member = self.array[indexPath.row]
            let deleteRow = self.dataBase.productDelete(pID: member.id)
            if deleteRow > 0 {
                self.array.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        item.image = UIImage(named: "trash")
        item.backgroundColor = UIColor(red: 0.55, green: 0.80, blue: 0.00, alpha: 1.00)
        
        let swipeActions = UISwipeActionsConfiguration(actions: [item])
        
        return swipeActions
    }
    
    //TODO: aşağıdaki kod parçası table view'de rowların yerlerinin değişmesini navigation bar üstündeki "Sırala" butonuyla sağlanıyor.
    // Ancak db'de ve array'de verileri updateleme işlemi eksik
    
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        array.swapAt(sourceIndexPath.row, destinationIndexPath.row)
//    }
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    @IBAction func sortBtn(_ sender: UIBarButtonItem) {
//        if array.count > 1 {
//            if tableView.isEditing {
//                tableView.isEditing = false
//            } else {
//                tableView.isEditing = true
//            }
//        }
//    }
    
    @objc func addTapped(){
        if self.array.count > 1 {
        let alertView = SCLAlertView()
        alertView.addButton("Sil") {
            self.array.removeAll()
            self.tableView.dataSource = nil
            self.dataBase.deleteAllList()
            self.tableView.reloadData()
        }
        alertView.showInfo("Lütfen Dikkat", subTitle: "Bu işlem tüm ürünlerinizi silecektir")
    }
}
}
