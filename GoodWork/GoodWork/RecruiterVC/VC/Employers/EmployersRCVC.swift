//
//  EmployersRCVC.swift
//  GoodWork
//
//  Created by Gaurav Jani on 24/04/23.
//

import UIKit

class EmployersRCVC: UIViewController {
    
    static let storyBoardIdentifier = "EmployersRCVC"
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var backButtonImageView: UIImageView!
    
    @IBOutlet weak var empoloyerTitleLabel: UILabel!
    @IBOutlet weak var nameTitleLabel: UILabel!
    
    @IBOutlet weak var employerListTableView: UITableView!
    
    var employerListArray = ["Mary Washington Healthcare", "Medical Solutions"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUPUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setUPUI(){
        
        self.view.backgroundColor =  GoodWorkAppColor.appBGPink
        
        self.backButtonImageView.image = UIImage(named: "Arrow")
        
        self.empoloyerTitleLabel.addTitleColorAndFont(title: "Employers", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 18, tintColor: GoodWorkAppColor.appRaisin)
        
        self.nameTitleLabel.addTitleColorAndFont(title: "Name", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 18, tintColor: GoodWorkAppColor.appEerieBlack)
        
        self.buttonActions()
        self.loadTableView()
    }
}

//MARK:- Button Actions
extension EmployersRCVC {
    
    func buttonActions(){
        self.backButton.addTarget(self, action: #selector(self.backButtonPressed(_:)), for: .touchUpInside)
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton){
        print("backButtonPressed")
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension EmployersRCVC : UITableViewDelegate, UITableViewDataSource {
    
    func loadTableView(){
        
        self.employerListTableView.register(UINib(nibName: PersonalInfoDetailsTableViewCell.reuseCellIdentifier, bundle: nil), forCellReuseIdentifier: PersonalInfoDetailsTableViewCell.reuseCellIdentifier)
        self.employerListTableView.delegate = self
        self.employerListTableView.dataSource = self
        
        self.employerListTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.employerListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonalInfoDetailsTableViewCell.reuseCellIdentifier, for: indexPath) as! PersonalInfoDetailsTableViewCell
        
        cell.profileInfoLabel.text = self.employerListArray[indexPath.row]
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        print("didSelectRowAt \(indexPath.row)")
    }
}
