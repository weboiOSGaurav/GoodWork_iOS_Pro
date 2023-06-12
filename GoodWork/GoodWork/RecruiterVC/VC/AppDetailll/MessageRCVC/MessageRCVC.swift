//
//  MessageRCVC.swift
//  GoodWork
//
//  Created by Gaurav Jani on 25/04/23.
//

import UIKit

class MessageRCVC: UIViewController {
    
    static let storyBoardIdentifier = "MessageRCVC"
    
    @IBOutlet weak var rightSideTopImageView: UIImageView!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var notificationImageView: UIImageView!
    @IBOutlet weak var notificationBGView: UIView!
    
    @IBOutlet weak var messageListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUPUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUPUI(){
        
        self.view.backgroundColor =  GoodWorkAppColor.appBGPink
        
        self.rightSideTopImageView.image = UIImage(named: "homeRightSideTop")
        self.profileImageView.image = UIImage(named: "profile")
        
        self.userNameLabel.addTitleColorAndFont(title: "Emna Watson", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 18, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.notificationImageView.image = UIImage(named: "notification")
        self.notificationBGView.addRadiusAndBGColour((self.notificationBGView.frame.height / 2), GoodWorkAppColor.appDarkPurple)
        
        self.loadTableView()
        self.buttonActions()
    }
}

extension MessageRCVC : UITableViewDelegate, UITableViewDataSource {
    
    func loadTableView(){
        
        self.messageListTableView.register(UINib(nibName: messageListTableViewCell.reuseCellIdentifier, bundle: nil), forCellReuseIdentifier: messageListTableViewCell.reuseCellIdentifier)
        self.messageListTableView.delegate = self
        self.messageListTableView.dataSource = self
        
        self.messageListTableView.reloadData()
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: messageListTableViewCell.reuseCellIdentifier, for: indexPath) as! messageListTableViewCell
        
        if indexPath.row == 0 {
            cell.jobTypeLabel.text = "James Bond"
        }else if indexPath.row == 1 {
            cell.jobTypeLabel.text = "Mary Smith"
            cell.userProfilePic.image = UIImage(named: "marry")
            cell.timeLable.text = "1d ago"
            cell.messageCount.isHidden = true
            cell.messageCountBGView.isHidden = true
        }
        
        return  cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: ChatRCVC.storyBoardIdentifier) as? ChatRCVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- Button Actions
extension MessageRCVC {
    
    func buttonActions(){
        self.profileButton.addTarget(self, action: #selector(self.profileButtonPressed(_:)), for: .touchUpInside)
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton){
        print("profileButtonPressed")
         guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: ProfileRCVC.storyBoardIdentifier) as? ProfileRCVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
