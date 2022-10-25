//
//  ViewController.swift
//  ApplicationFormTestTask
//
//  Created by Ксения Кобак on 24.10.2022.
//
import UIKit


final class ViewController: UIViewController  {
    
    
    var dataArray = [Child]()
    private var mainView = MainView()
    
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeNotifications()
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view = mainView
        view.backgroundColor = .white
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        registerForKeyboardNotifications()
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
    }
    
    
    //MARK: - Actions
    
    @objc private func cancelButtonTapped() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: Text.actionDelete, style: .default , handler:{ action in
            self.dataArray = []
            self.mainView.tableView.reloadData()
            self.mainView.cancelButton.isHidden = true
            
        }))
        
        alert.addAction(UIAlertAction(title: Text.actionCancel, style: .cancel , handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func addButtonTapped(sender: UIButton) {
        
        if children.count < 5 {
            dataArray.append(Child(name: "test", age: 100))
            mainView.cancelButton.isHidden = false
            mainView.tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
        }
        
        if dataArray.count == 5 {
            sender.isHidden = true
        }
        
    }
    
    @objc private func deleteCell(sender: UIButton) {
        if let indexPath = mainView.tableView.indexPath(for: sender.superview?.superview as! ChildCell){
            dataArray.removeLast()
            mainView.tableView.deleteRows(at: [indexPath], with: .none)
            
        }
        if dataArray.count < 5 {
            mainView.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
            mainView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
    }
    
    //MARK: - Notificatios for keyboard
    
    
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
    
    @objc private func keyboardWillBeHidden(notification: NSNotification) {
        
        self.view.frame.origin.y = 0
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private  func removeNotifications () {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
}

//MARK: - TableViewDelegate and DataSource methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return  dataArray.count
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  indexPath.section == 0 {
            let cell = ParentCell(style: .default, reuseIdentifier: CellIDs.parentCell)
            cell.addButton.addTarget(self, action: #selector(addButtonTapped(sender:)), for: .touchUpInside)
            if dataArray.count == 5 {
                cell.addButton.isHidden = true
            }
            return cell
        } else {
            let cell = ChildCell(style: .default, reuseIdentifier: CellIDs.childCell)
            cell.deleteButton.addTarget(self, action: #selector(deleteCell(sender:)), for: .touchUpInside)
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 270
        } else {
            return 180
        }
    }
    
    
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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






