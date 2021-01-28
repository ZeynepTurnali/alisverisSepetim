//
//  ViewController.swift
//  alisverisSepetim

import UIKit
import Lottie
import SCLAlertView

class ViewController: UIViewController {
    
    @IBOutlet weak var productTitleText: UITextField!
    @IBOutlet weak var productDetailTextView: UITextView!
    
    let database = DataBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shoppingAnimation()
        
        database.databaseConnection()
        //  print(database.productList())
       
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.shoppingAnimation()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.shoppingAnimation()
    }
    
    @IBAction func productAddButton(_ sender: UIButton){
        if addProduct(addingTitle: productTitleText.text!, addingDetail: productDetailTextView.text){
            productTitleText.text = nil
            productDetailTextView.text = nil
        }
    }
    
    func addProduct(addingTitle: String, addingDetail: String) -> Bool{
        if productTitleText.text != "" {
            let row = database.productInsertAction(myTitle: addingTitle, myDetail: addingDetail)
            SCLAlertView().showSuccess("Ürün listenize eklendi", subTitle: "Listenizi Görüntüleyebilirsiniz")
        } else {
            SCLAlertView().showWarning("Ürün adı eksik", subTitle: "Lütfen Ürün Adını Giriniz")
            return false
        }
        return true
    }
    
    func shoppingAnimation(){
        let jsonName = "shoppingAnimation"
        let animation = Animation.named(jsonName)
        let width = view.frame.width
        // let height = view.frame.height
        
        // Load animation to AnimationView
        let animationView = AnimationView(animation: animation)
        animationView.frame = CGRect(x: width / 2 - 75 , y: 100, width: 150, height: 150)
        
        // Add animationView as subview
        view.addSubview(animationView)
        
        // Play the animation
        animationView.loopMode = .loop
        animationView.play()
    }
}

