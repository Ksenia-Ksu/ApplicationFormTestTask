//
//  ViewController.swift
//  ApplicationFormTestTask
//
//  Created by Ксения Кобак on 24.10.2022.
//

import UIKit

class ViewController: UIViewController  {
    
    var dataArray = [Int]()
    var mainView = MainView()
    var isKeyboardAppear = false
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view = mainView
        view.backgroundColor = .white
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.nameTF.delegate = self
        mainView.ageTF.delegate = self
        registerForKeyboardNotifications()
        
        
        if dataArray.count == 0 {
            mainView.cancelButton.isHidden = true
        }
        
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        mainView.addButton.addTarget(self, action: #selector(addButtonTapped(sender:)), for: .touchUpInside)
        
    }
    
    
    
    
    
    //MARK: - Actions
    
    @objc func cancelButtonTapped() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: Text.actionDelete, style: .default , handler:{ action in
            self.dataArray = []
            self.mainView.tableView.reloadData()
            self.mainView.cancelButton.isHidden = true
            self.mainView.addButton.isHidden = false
            self.mainView.clearTextFields()
        }))
        
        alert.addAction(UIAlertAction(title: Text.actionCancel, style: .cancel , handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func addButtonTapped(sender: UIButton) {
        if dataArray.count < 5 {
            dataArray.append(0)
            mainView.cancelButton.isHidden = false
            mainView.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
        if dataArray.count == 5 {
            sender.isHidden = true
        }
    }
    
    //MARK: - Notificatios for keyboard
    
    func removeNotifications () {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShown),name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillBeHidden),name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShown(notificiation: NSNotification) {
        guard let userInfo = notificiation.userInfo,
              let keboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTF = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keboardFrame.cgRectValue.origin.y
        let convertedTFFrame = view.convert(currentTF.frame, from: currentTF.superview)
        let textFieldBottomY = convertedTFFrame.origin.y + convertedTFFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTFFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY/2) * -1 + 120
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification) {
        
        self.view.frame.origin.y = 0
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeNotifications()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
}

//MARK: - TableViewDelegate and DataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIDs.childCell, for: indexPath) as! ChildCell
        cell.deleteButton.addTarget(self, action: #selector(deleteCell(sender:)), for: .touchUpInside)
        return cell
        
    }
    
    
    @objc func deleteCell(sender: UIButton) {
        if let indexPath = mainView.tableView.indexPath(for: sender.superview?.superview as! ChildCell){
            dataArray.remove(at: indexPath.row)
            mainView.tableView.deleteRows(at: [indexPath], with: .automatic)
            if dataArray.count < 5  &&  mainView.addButton.isHidden == true {
                mainView.addButton.isHidden = false }
            
            if dataArray.count == 5 && mainView.addButton.isHidden == false {
                mainView.addButton.isHidden = true
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == mainView.ageTF {
            textField.keyboardType = .numberPad
        }
        return true
    }
}

// MARK: Keyboard
extension ViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        print("userInfo: \(userInfo)")
        print("keyboardFrame: \(keyboardFrame)")
        print("currentTextField: \(currentTextField)")
    }
}






