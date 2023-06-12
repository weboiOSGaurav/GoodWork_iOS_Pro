//
//  ProfileRCVC.swift
//  GoodWork
//
//  Created by Gaurav Jani on 24/04/23.
//

import UIKit
import SwiftyAttributes

class ProfileRCVC: UIViewController {
    
    static let storyBoardIdentifier = "ProfileRCVC"
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    
    @IBOutlet weak var rightSideTopImageView: UIImageView!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var settingBGView: UIView!
    @IBOutlet weak var settingImageView: UIImageView!
    
    @IBOutlet weak var myProfileTitle: UILabel!
    
    @IBOutlet weak var userProfileTitleImageView: UIImageView!
    @IBOutlet weak var userProfileShadowView: UIView!
    
    
    @IBOutlet weak var cameraBGView: UIView!
    @IBOutlet weak var cameraImageView: UIImageView!
    
    @IBOutlet weak var userFullNameLable: UILabel!
    
    @IBOutlet weak var profileInfoTableview: UITableView!
    
    @IBOutlet weak var logOutMainBGView: UIView!
    @IBOutlet weak var logOutView: UIView!
    @IBOutlet weak var crossImageView: UIImageView!
    @IBOutlet weak var yesLogOutButton: UIButton!
    
    @IBOutlet weak var closeLogOutButton: UIButton!
    @IBOutlet weak var logOutFromAppLabel: UILabel!
    @IBOutlet weak var areYouSureLabel: UILabel!
    
    let profileDetailsAry = ["Employers","Account Info","About Me","Help & Support","About Goodwork","Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUPUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.myProfileTitle.text = ""
        
        let log = "My".withAttributes([
            .textColor(GoodWorkAppColor.appDarkPurple),
            .font(GoodWorkApp.goodWorkAppFont(GoodWorkAppFontName.NeueKabelMedium, 32))
        ])
        
        let inn = " Profile".withAttributes([
            .textColor(GoodWorkAppColor.appLightPink),
            .font(GoodWorkApp.goodWorkAppFont(GoodWorkAppFontName.NeueKabelMedium, 32))
        ])
        
        let finalString = (log + inn)
        
        self.myProfileTitle.attributedText = finalString
        self.logOutMainBGView.isHidden = true
    }
    
    
    func setUPUI(){
        
        self.view.backgroundColor =  GoodWorkAppColor.appBGPink
        
        self.rightSideTopImageView.image = UIImage(named: "Group3")
        self.rightSideTopImageView.backgroundColor = .clear
        self.userProfileImageView.image = UIImage(named: "profile")
        
        self.userNameLabel.addTitleColorAndFont(title: "Emma Watson", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 18, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.settingBGView.addRadiusAndBGColour((self.settingBGView.frame.height / 2), GoodWorkAppColor.appDarkPurple)
        
        self.settingImageView.image = UIImage(named: "notification")
        
        self.userNameLabel.addTitleColorAndFont(title: "Emma Watson", fontName: GoodWorkAppFontName.NeueKabelRegular, fontSize: 18, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.userProfileTitleImageView.image = UIImage(named: "profile11")
        self.userProfileTitleImageView.addRadiusAndBGColour(14, .clear)
        self.userProfileShadowView.addRadiusAndBGColour(14, GoodWorkAppColor.appArsenic)
        self.userProfileShadowView.isHidden = true
        
        self.userFullNameLable.addTitleColorAndFont(title: "Emma Watson", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 24, tintColor: GoodWorkAppColor.appDarkPurple)
        
        
        self.cameraBGView.cornerRadiusWithBgColour((Int(self.cameraBGView.frame.height)/2), bgColour: GoodWorkAppColor.appGre)
        self.cameraImageView.image = UIImage(named: "camera")
        
        self.crossImageView.image = UIImage(named: "Close")
        
        self.cameraBGView.isHidden = true
        self.crossImageView.isHidden = true
        
        self.logOutFromAppLabel.addTitleColorAndFont(title: "Logout from Application", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 24, tintColor: GoodWorkAppColor.appMirage)
        
        self.areYouSureLabel.addTitleColorAndFont(title: "Are you sure want \n\nto Log out?", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 16, tintColor: GoodWorkAppColor.appBlack)
        
        
        self.yesLogOutButton.addRadiusBGColorTitleColorFont(title: "Yes, Logout", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 18, radius: self.yesLogOutButton.frame.height / 2, bgColor: GoodWorkAppColor.appDarkPurple, tintColor: GoodWorkAppColor.appOffWhite)
        
        
        self.logOutView.addRadiusAndBGColour(12, GoodWorkAppColor.appBGPink)
        self.logOutMainBGView.backgroundColor = GoodWorkAppColor.appBlack.withAlphaComponent(0.50)
        
        self.loadTableView()
        self.buttonActions()
    }
}

extension ProfileRCVC : UITableViewDelegate, UITableViewDataSource {
    
    func loadTableView(){
        
        self.profileInfoTableview.register(UINib(nibName: ProfileInfoTableViewCell.reuseCellIdentifier, bundle: nil), forCellReuseIdentifier: ProfileInfoTableViewCell.reuseCellIdentifier)
        
        self.profileInfoTableview.delegate = self
        self.profileInfoTableview.dataSource = self
        
        
        self.profileInfoTableview.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.profileDetailsAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoTableViewCell.reuseCellIdentifier, for: indexPath) as! ProfileInfoTableViewCell
        
        cell.profileInfoLabel.text = self.profileDetailsAry[indexPath.row]
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        print("didSelectRowAt \(indexPath.row)")
        
        self.openProfileDetailsVC(indexPath.row)
    }
}

extension ProfileRCVC {
    func openProfileDetailsVC(_ indexNo : Int){
        
        switch  indexNo{
        case 0:
            print("0")
            guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: EmployersRCVC.storyBoardIdentifier) as? EmployersRCVC else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            print("1")
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: AccountInfoRCVC.storyBoardIdentifier) as? AccountInfoRCVC else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            print("2")
            guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: AboutMeRCVC.storyBoardIdentifier) as? AboutMeRCVC else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            print("3")
            guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: HelpAndSupportRCVC.storyBoardIdentifier) as? HelpAndSupportRCVC else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            print("4")
            guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: AboutUSRCVC.storyBoardIdentifier) as? AboutUSRCVC else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            print("5")
//            self.logOutMainBGView.isHidden = false
            let destVC = mainStoryboard.instantiateViewController(withIdentifier: OnboardingVC.storyBoardIdentifier)
            let rootViewController = UINavigationController(rootViewController: destVC)
            UIApplication.key?.rootViewController = rootViewController
        default:
            print("default")
        }
        
    }
}

//MARK:- Button Actions
extension ProfileRCVC {
    
    func buttonActions(){
        self.backButton.addTarget(self, action: #selector(self.backButtonPressed(_:)), for: .touchUpInside)
        self.notificationButton.addTarget(self, action: #selector(self.notificationButtonPressed(_:)), for: .touchUpInside)
        self.yesLogOutButton.addTarget(self, action: #selector(self.yesLogOutButtonPressed(_:)), for: .touchUpInside)
        self.closeLogOutButton.addTarget(self, action: #selector(self.closeLogOutButtonPressed(_:)), for: .touchUpInside)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton){
        print("backButtonPressed")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func notificationButtonPressed(_ sender: UIButton){
        print("notificationButtonPressed")
        
    }
    
    @IBAction func closeLogOutButtonPressed(_ sender: UIButton){
        print("closeLogOutButtonPressed")
        
        self.logOutMainBGView.isHidden = true
    }
    
    @IBAction func yesLogOutButtonPressed(_ sender: UIButton){
        print("yesLogOutButtonPressed")
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let destVC = mainStoryboard.instantiateViewController(withIdentifier: OnboardingVC.storyBoardIdentifier)
//
        let rootViewController = UINavigationController(rootViewController: destVC)
        UIApplication.key?.rootViewController = rootViewController
    }
}
