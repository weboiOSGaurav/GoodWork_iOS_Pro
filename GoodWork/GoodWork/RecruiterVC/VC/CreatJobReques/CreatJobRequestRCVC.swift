//
//  CreatJobRequestRCVC.swift
//  GoodWork
//
//  Created by Gaurav Jani on 27/04/23.
//

import UIKit
import KMPlaceholderTextView

class CreatJobRequestRCVC: UIViewController {
    
    static let storyBoardIdentifier = "CreatJobRequestRCVC"
    
    @IBOutlet weak var backButtonImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var createRequestTitleLabel: UILabel!
    
    @IBOutlet weak var shadowBgView1: UIView!
    @IBOutlet weak var shadowBgView2: UIView!
    @IBOutlet weak var shadowBgView3: UIView!
    @IBOutlet weak var shadowBgView4: UIView!
    @IBOutlet weak var shadowBgView5: UIView!
    @IBOutlet weak var shadowBgView6: UIView!
    
    @IBOutlet weak var jobNameBgView: UIView!
    @IBOutlet weak var specialityJobBgView: UIView!
    @IBOutlet weak var jobLocationBgView: UIView!
    @IBOutlet weak var durationBgView: UIView!
    @IBOutlet weak var weeklyPayBgView: UIView!
    @IBOutlet weak var jobDescriptionBgView: UIView!
    
    @IBOutlet weak var jobNameTextField: UITextField!
    @IBOutlet weak var specialityTextField: UITextField!
    @IBOutlet weak var jobLocationTextField: UITextField!
    @IBOutlet weak var workDurationTextField: UITextField!
    @IBOutlet weak var weeklyPayTextField: UITextField!
    
    @IBOutlet weak var jobDescriptionTextView: KMPlaceholderTextView!
    
    
    @IBOutlet weak var publishedNowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setUPUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setUPUI(){
        
        self.view.backgroundColor =  GoodWorkAppColor.appBGPink
        self.backButtonImageView.image = UIImage(named: "backButton")
        self.createRequestTitleLabel.addTitleColorAndFont(title: "Create Opportunity", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 18, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.jobDescriptionBgView.addBorderWidthColour(2, GoodWorkAppColor.appDarkPurple, 14)
        self.weeklyPayBgView.addBorderWidthColour(2, GoodWorkAppColor.appDarkPurple, 14)
        self.durationBgView.addBorderWidthColour(2, GoodWorkAppColor.appDarkPurple, 14)
        self.jobLocationBgView.addBorderWidthColour(2, GoodWorkAppColor.appDarkPurple, 14)
        self.specialityJobBgView.addBorderWidthColour(2, GoodWorkAppColor.appDarkPurple, 14)
        self.jobNameBgView.addBorderWidthColour(2, GoodWorkAppColor.appDarkPurple, 14)
        
        self.shadowBgView1.shadowWithRadiusAndColour(14, GoodWorkAppColor.appDavysGrey)
        self.shadowBgView2.shadowWithRadiusAndColour(14, GoodWorkAppColor.appDavysGrey)
        self.shadowBgView3.shadowWithRadiusAndColour(14, GoodWorkAppColor.appDavysGrey)
        self.shadowBgView4.shadowWithRadiusAndColour(14, GoodWorkAppColor.appDavysGrey)
        self.shadowBgView5.shadowWithRadiusAndColour(14, GoodWorkAppColor.appDavysGrey)
        self.shadowBgView6.shadowWithRadiusAndColour(14, GoodWorkAppColor.appDavysGrey)
        
        
        
        self.jobNameTextField.addTitleColorAndFont(placeHolder: "Enter job name", fontName: GoodWorkAppFontName.NeueKabelRegular, fontSize: 16, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.specialityTextField.addTitleColorAndFont(placeHolder: "Specialty", fontName: GoodWorkAppFontName.NeueKabelRegular, fontSize: 16, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.jobLocationTextField.addTitleColorAndFont(placeHolder: "Enter Job Location (City, State)", fontName: GoodWorkAppFontName.NeueKabelRegular, fontSize: 16, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.workDurationTextField.addTitleColorAndFont(placeHolder: "Enter Work Duration", fontName: GoodWorkAppFontName.NeueKabelRegular, fontSize: 16, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.weeklyPayTextField.addTitleColorAndFont(placeHolder: "Enter Weekly Pay", fontName: GoodWorkAppFontName.NeueKabelRegular, fontSize: 16, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.jobDescriptionTextView.font = GoodWorkApp.goodWorkAppFont(GoodWorkAppFontName.NeueKabelRegular, 16)
        
        self.publishedNowButton.addRadiusAndBGColour((self.publishedNowButton.frame.height / 2), GoodWorkAppColor.appDarkPurple)
        
        self.buttonActions()
    }
}

//MARK:- Button Actions
extension CreatJobRequestRCVC {
    
    func buttonActions(){
        self.backButton.addTarget(self, action: #selector(self.backButtonPressed(_:)), for: .touchUpInside)
        self.publishedNowButton.addTarget(self, action: #selector(self.publishedNowButtonPressed(_:)), for: .touchUpInside)
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton){
        print("profileButtonPressed")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func publishedNowButtonPressed(_ sender: UIButton){
        print("publishedNowButtonPressed")
        
        guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: EditCreatJobRequestRCVC.storyBoardIdentifier) as? EditCreatJobRequestRCVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension UITextField {
    
    func addTitleColorAndFont(placeHolder: String, fontName : GoodWorkAppFontName, fontSize : CGFloat, tintColor :UIColor){
        
        self.textColor = GoodWorkAppColor.appColour
        self.placeholder = placeHolder
        self.font = GoodWorkApp.goodWorkAppFont(fontName, fontSize)
    }
}


