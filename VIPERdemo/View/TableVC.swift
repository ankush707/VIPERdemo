//
//  TableVC.swift
//  VIPERdemo
//
//  Created by Ankush on 31/03/23.
//

import Foundation
import UIKit

//ViewController
//Protocol
//Ref to Presenter

protocol AnyView {
    
    var tablePresenter: AnyPresenter? { get set }
    
    func presentUsers(with users: TableEntity)
    func presentAlert(with alertMessage: String)
}

class TableVC: UIViewController, AnyView {
    var tablePresenter: AnyPresenter?
    
    func presentUsers(with users: TableEntity) {
        DispatchQueue.main.async {
            self.userData = users
            let filterArr = users.data?.filter { $0.parentID == nil || $0.isCollapsed == false}
            
            if let filterArr {
                self.filteredArr = filterArr
            }
            self.tableVw.reloadData()
        }
    }
    
    func presentAlert(with alertMessage: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
  
    private let lbl : UILabel = {
        
        let lbl = UILabel.init(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 50))
        lbl.text = Constants.listHeader
        lbl.textAlignment = .center
        lbl.textColor = .red
        lbl.font = UIFont(name: Constants.fontName, size: 26.0)
        return lbl
    }()
    
    private let tableVw : UITableView = {
        
        let tableVIew = UITableView.init(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-130))
        
        return tableVIew
    }()
    
    
    private var userData: TableEntity?
    private var filteredArr: [InnerEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableVw.delegate = self
        self.tableVw.dataSource = self
        self.tableVw.separatorColor = .black
        
    }
    
    override func viewDidLayoutSubviews() {
        self.view.addSubview(self.lbl)
        self.view.addSubview(self.tableVw)
    }
    
}

extension TableVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.filteredArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        self.setCellData(cell: cell, index: indexPath.row)
        return cell
    }
    
    //Using default cell, else i should have done this in the Custom TableView Cell Class
    private func setCellData(cell: UITableViewCell, index: Int) {
        
        cell.textLabel?.text = self.filteredArr[index].title
        
        if self.filteredArr[index].parentID == nil  {
            self.setCellLayout(cell: cell, image: Constants.imageName, imageTintColor: .white, textColor: .white, contentBg: .systemCyan, textSize: 20.0)
        } else if self.filteredArr[index].children?.count ?? 0 > 0 {
            self.setCellLayout(cell: cell, image: Constants.imageName, imageTintColor: .blue, textColor: .black, contentBg: .systemGray5, textSize: 17.0)
        } else {
            self.setCellLayout(cell: cell, image: "", imageTintColor: .systemGray6, textColor: .darkGray, contentBg: .systemGray6, textSize: 14.0)
        }
        
    }
    
    private func setCellLayout(cell: UITableViewCell, image: String, imageTintColor: UIColor, textColor: UIColor, contentBg: UIColor, textSize: CGFloat) {
        cell.imageView?.image = UIImage(systemName: image)
        cell.imageView?.tintColor = imageTintColor
        cell.contentView.backgroundColor = contentBg
        cell.textLabel?.textColor = textColor
        cell.textLabel?.font = UIFont(name: Constants.fontName, size: textSize)
    }
}

extension TableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            tableView.deselectRow(at: indexPath, animated: false)
        
            let currentIndex = indexPath
            let childArray = self.userData?.data?.filter { $0.parentID == self.filteredArr[indexPath.row].id }
            
           
            
            if let childArray = childArray,childArray.count > 0 {
                
                if self.filteredArr[indexPath.row].isCollapsed {
                    
                    let range = currentIndex.row+1...currentIndex.row + childArray.count
                    let indexPaths = range.map { IndexPath(row: $0, section: 0) }
                    self.tableVw.beginUpdates()
                    
                    self.filteredArr.insert(contentsOf: childArray, at: currentIndex.row + 1)
                    self.tableVw.insertRows(at: indexPaths, with: .automatic)
                    self.tableVw.endUpdates()
                    
                } else {
                    let additionalCount: Int = self.recursiveFunction(currentId: self.filteredArr[indexPath.row].id)
                    
                    let range = currentIndex.row+1...currentIndex.row + childArray.count + additionalCount
                    let indexPaths = range.map { IndexPath(row: $0, section: currentIndex.section) }
                    self.tableVw.beginUpdates()
                    
                    self.filteredArr.removeSubrange(range)
                    self.tableVw.deleteRows(at: indexPaths, with: .automatic)
                }
                self.tableVw.endUpdates()
            }
            self.filteredArr[indexPath.row].updateCollapsed(value: !self.filteredArr[indexPath.row].isCollapsed)
            
        }
        
    }
    
    
    
    func recursiveFunction(currentId: Int?) -> Int {
        
        let childArray = self.filteredArr.filter { $0.parentID == currentId }
        
        var additionalCount: Int = 0
        
            for obj in childArray {
                
                if obj.isCollapsed == false {
                    let newArr = self.filteredArr.filter { $0.parentID == obj.id }
                    additionalCount += newArr.count
                    
                    let filArr = newArr.filter { $0.isCollapsed == false }
                    
                    if filArr.count > 0 {
                        additionalCount += self.recursiveFunction(currentId: obj.id)
                    }
                }
            }
        
        return additionalCount
    }
    
    
    
}
