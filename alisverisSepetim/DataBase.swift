//
//  DataBase.swift
//  alisverisSepetim

import Foundation
import SQLite

struct Product{
    var id:Int64 = 0
    var title: String = ""
    var detail: String = ""
}

class DataBase {
    var dataBase:Connection!
    var tableProduct = Table("product")
    
    let id = Expression<Int64>("id")
    let title = Expression<String>("title")
    let detail = Expression<String>("detail")
    
    let path  = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    func databaseConnection(){
        let databasePath = path + "/db.sqlite3"
        print("Full Path: \(databasePath)")
        dataBase = try! Connection(databasePath)
        
        do {
            try dataBase.scalar(tableProduct.exists)
        } catch {
            try! dataBase.run(tableProduct.create { t in
                t.column(id, primaryKey: true)
                t.column(title)
                t.column(detail)
            })
        }
    }
    
    func productInsertAction(myTitle: String, myDetail: String) -> Int64{
        
        do{
            let insert = tableProduct.insert(self.title <- myTitle, self.detail <- myDetail)
            return try dataBase.run(insert)
        } catch {
            return -1
        }
    }
    
    func productList() -> [Product]{
        var array:[Product] = []
        let products = try! dataBase.prepare(tableProduct)
        for member in products {
            print("product id: \(member[id])")
            let productMember = Product(id: member[id], title: member[title], detail: member[detail])
            array.append(productMember)
        }
        
        return array
    }
    
    func productDelete(pID: Int64) -> Int {
        let filteredProduct = tableProduct.filter(id == pID)
        return try! dataBase.run(filteredProduct.delete())
    }
    
    func deleteAllList() -> Bool{
        let numberOfProducts = try! dataBase.scalar(tableProduct.count)
        if numberOfProducts > 0 {
            //tableProduct.drop()
            try! dataBase.scalar("DELETE FROM product")
            return true
        } else{
            return false
        }
    }

    
}
