//
//  CreatingJobPostRCVC.swift
//  GoodWork
//
//  Created by Gaurav Jani on 27/04/23.
//

import UIKit

class CreatingJobPostRCVC: UIViewController {
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var createPostButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var pluseimageView: UIImageView!
    @IBOutlet weak var createPostBGView: UIView!
    
    @IBOutlet weak var draftsLabel: UILabel!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var onHoldLabel: UILabel!
    @IBOutlet weak var onClosedLabel: UILabel!
    @IBOutlet weak var noJobPostedLabel: UILabel!
    @IBOutlet weak var startPostedLabel: UILabel!
    
    @IBOutlet weak var creatingJobPostTableview: UITableView!
    
    
    
    var selectedJobType = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUPUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUPUI(){
        
        self.view.backgroundColor =  GoodWorkAppColor.appBGPink
        
        self.profileImageView.image = UIImage(named: "profile")
        
        self.userNameLabel.addTitleColorAndFont(title: "Opportunities Manager", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 18, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.pluseimageView.image = UIImage(named: "pluseGreen")
        self.createPostBGView.addRadiusAndBGColour((self.createPostBGView.frame.height / 2), GoodWorkAppColor.appDarkPurple)
        
        self.draftsLabel.addTitleColorAndFont(title: "Drafts", fontName: GoodWorkAppFontName.NeueKabelRegular, fontSize: 14, tintColor: GoodWorkAppColor.appGrayCSS)
        
        self.publishedLabel.addTitleColorAndFont(title: "Published", fontName: GoodWorkAppFontName.NeueKabelRegular, fontSize: 14, tintColor: GoodWorkAppColor.appGrayCSS)
        
        self.onHoldLabel.addTitleColorAndFont(title: "Hidden", fontName: GoodWorkAppFontName.NeueKabelRegular, fontSize: 14, tintColor: GoodWorkAppColor.appGrayCSS)
        
        self.onClosedLabel.addTitleColorAndFont(title: "Closed", fontName: GoodWorkAppFontName.NeueKabelRegular, fontSize: 14, tintColor: GoodWorkAppColor.appGrayCSS)
        
        
        self.noJobPostedLabel.addTitleColorAndFont(title: "No Job  Posted.", fontName: GoodWorkAppFontName.NeueKabelRegular, fontSize: 24, tintColor: GoodWorkAppColor.appBlack)
        
        self.startPostedLabel.addTitleColorAndFont(title: "Start Creating Job Request", fontName: GoodWorkAppFontName.NeueKabelRegular, fontSize: 24, tintColor: GoodWorkAppColor.appBlack)
        
        self.loadTableView()
        self.buttonActions()
        
        self.creatingJobPostTableview.isHidden = true
    }
}

//MARK:- Button Actions
extension CreatingJobPostRCVC {
    
    func buttonActions(){
        self.profileButton.addTarget(self, action: #selector(self.profileButtonPressed(_:)), for: .touchUpInside)
        
        self.createPostButton.addTarget(self, action: #selector(self.createPostButtonPressed(_:)), for: .touchUpInside)
        
        
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton){
        print("profileButtonPressed")
        guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: ProfileRCVC.storyBoardIdentifier) as? ProfileRCVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createPostButtonPressed(_ sender: UIButton){
        print("createPostButtonPressed")
        guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: CreatJobRequestRCVC.storyBoardIdentifier) as? CreatJobRequestRCVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func postTypeButtonPressed(_ sender: UIButton){
        print("postTypeButtonPressed")
        
        self.noJobPostedLabel.isHidden = true
        self.startPostedLabel.isHidden = true
        self.creatingJobPostTableview.isHidden = false
        
        self.draftsLabel.textColor = GoodWorkAppColor.appGrayCSS
        self.publishedLabel.textColor = GoodWorkAppColor.appGrayCSS
        self.onHoldLabel.textColor = GoodWorkAppColor.appGrayCSS
        self.onClosedLabel.textColor = GoodWorkAppColor.appGrayCSS
        
        self.draftsLabel.font = GoodWorkApp.goodWorkAppFont(GoodWorkAppFontName.NeueKabelRegular, 14)
        self.publishedLabel.font = GoodWorkApp.goodWorkAppFont(GoodWorkAppFontName.NeueKabelRegular, 14)
        self.onHoldLabel.font = GoodWorkApp.goodWorkAppFont(GoodWorkAppFontName.NeueKabelRegular, 14)
        self.onClosedLabel.font = GoodWorkApp.goodWorkAppFont(GoodWorkAppFontName.NeueKabelRegular, 14)
        
        
        switch  sender.tag{
            
        case 0 :
            print("0")
            self.draftsLabel.textColor = GoodWorkAppColor.appDarkPurple
            self.draftsLabel.font = GoodWorkApp.goodWorkAppFont(GoodWorkAppFontName.NeueKabelMedium, 14)
            self.selectedJobType = 0
        case 1 :
            print("1")
            self.publishedLabel.textColor = GoodWorkAppColor.appDarkPurple
            self.publishedLabel.font = GoodWorkApp.goodWorkAppFont(GoodWorkAppFontName.NeueKabelMedium, 14)
            self.selectedJobType = 1
        case 2 :
            print("2")
            self.onHoldLabel.textColor = GoodWorkAppColor.appDarkPurple
            self.onHoldLabel.font = GoodWorkApp.goodWorkAppFont(GoodWorkAppFontName.NeueKabelMedium, 14)
            self.selectedJobType = 2
        case 3 :
            print("2")
            self.onClosedLabel.textColor = GoodWorkAppColor.appDarkPurple
            self.onClosedLabel.font = GoodWorkApp.goodWorkAppFont(GoodWorkAppFontName.NeueKabelMedium, 14)
            self.selectedJobType = 3
            
        default:
            print("default:")
        }
        
        self.creatingJobPostTableview.reloadData()
    }
}

extension CreatingJobPostRCVC : UITableViewDelegate, UITableViewDataSource {
    
    func loadTableView(){
        
        self.creatingJobPostTableview.register(UINib(nibName: CreatedJobTableViewCell.reuseCellIdentifier, bundle: nil), forCellReuseIdentifier: CreatedJobTableViewCell.reuseCellIdentifier)
        self.creatingJobPostTableview.delegate = self
        self.creatingJobPostTableview.dataSource = self
        
        self.creatingJobPostTableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.selectedJobType == 3 {
            
            return 180
        }else{
            return 156
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.selectedJobType == 1{
            return 2
        }else if self.selectedJobType == 2{
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CreatedJobTableViewCell.reuseCellIdentifier, for: indexPath) as! CreatedJobTableViewCell
        
        cell.jobSaveImageView.isHidden = true
        cell.appliedCount.isHidden = true
        
        cell.mainBgViewHeightConstrain.constant = 136
        cell.shadowBgViewHeightConstrain.constant = 136
        cell.startDate.isHidden = true
        cell.endDate.isHidden = true
        if self.selectedJobType == 0 {
            
        }else if self.selectedJobType == 1 {
            
            cell.appliedCount.isHidden = false
            
            if indexPath.row == 0 {
                cell.jobYye.text = "Local"
                cell.appliedCount.text = "0 Workers Applied"
            }else{
                cell.jobYye.text = "Travel"
                cell.appliedCount.text = "15+ Workers Applied"
            }

        }else if self.selectedJobType == 2 {
            cell.jobSaveImageView.isHidden = false
            cell.appliedCount.isHidden = false
            cell.jobYye.text = "Travel"
            cell.appliedCount.text = "15+ Workers Applied"
            
        }else if self.selectedJobType == 3 {
            cell.appliedCount.isHidden = false
            cell.mainBgViewHeightConstrain.constant = 160
            cell.shadowBgViewHeightConstrain.constant = 160
            cell.startDate.isHidden = false
            cell.endDate.isHidden = false
        }
        
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if self.selectedJobType == 0 {
            guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: EditJobRCVC.storyBoardIdentifier) as? EditJobRCVC else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }else if self.selectedJobType == 1 {
            guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: HoldAndPublishedRCVC.storyBoardIdentifier) as? HoldAndPublishedRCVC else { return }
            vc.isFromHoldApp = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: HoldAndPublishedRCVC.storyBoardIdentifier) as? HoldAndPublishedRCVC else { return }
            vc.isFromHoldApp = false
            self.navigationController?.pushViewController(vc, animated: true)
            
//            self.tabBarController?.tabBar.isHidden = true
////            guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: NurseAppliedListRCVC.storyBoardIdentifier) as? NurseAppliedListRCVC else { return }
////            vc.pushOnHoldNurseVC = self
////            vc.shoTabBarOBJ = self
////            vc.modalPresentationStyle = .overCurrentContext
////            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
}

extension CreatingJobPostRCVC : pushOnHoldNurseVC, shoTabBarVC {
    func pushOnHoldNurseVC(){
        guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: HoldAndPublishedRCVC.storyBoardIdentifier) as? HoldAndPublishedRCVC else { return }
        vc.isFromHoldApp = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func shoTabBarVC(){
        self.tabBarController?.tabBar.isHidden = false
    }
}

protocol pushOnHoldNurseVC {
    func pushOnHoldNurseVC()
}

protocol shoTabBarVC {
    func shoTabBarVC()
}
