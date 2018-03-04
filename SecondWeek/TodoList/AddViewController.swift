//
//  AddViewController.swift
//  TodoList
//
//  Created by Stan on 2018-02-26.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet var talkBtn: UIButton!
    @IBOutlet var phoneBtn: UIButton!
    @IBOutlet var shopBtn: UIButton!
    @IBOutlet var planeBtn: UIButton!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var doneBtn: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    
    var iconName = "talk"
    lazy var btnGroup = [talkBtn,phoneBtn,shopBtn,planeBtn]
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    Cancel the Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func talkBtnClick(_ sender: Any) {
        setBtnStatus()

        talkBtn.isSelected = true
        iconName = "talk"
    }
    
    @IBAction func phoneBtnClick(_ sender: Any) {
        setBtnStatus()

        phoneBtn.isSelected = true
        iconName = "phone"

    }
    @IBAction func shopBtnClick(_ sender: Any) {
        setBtnStatus()

        shopBtn.isSelected = true
        iconName = "shop"

    }
    @IBAction func planeBtnClick(_ sender: Any) {
        setBtnStatus()
        planeBtn.isSelected = true
        iconName = "air"

    }
    
    @IBAction func doneBtnClick(_ sender: Any) {
        saveData()
        
        navigationController?.popViewController(animated: true)
    }
    
    private func setBtnStatus() {
        for item in btnGroup {
            item?.isSelected = false
        }
    }
    
    private func saveData() {

        let path = NSHomeDirectory() + "/Documents/todolist.plist"
        guard let datas = NSMutableArray.init(contentsOfFile: path) else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let result: [String: Any] = ["title": titleTextField.text ?? "", "date": dateFormatter.string(from: datePicker.date), "icon": iconName]

        datas.add(result)
        datas.write(toFile: path, atomically: true)
    }
}


