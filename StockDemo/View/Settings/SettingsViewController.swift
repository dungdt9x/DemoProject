//
//  SettingsViewController.swift
//  StockDemo
//
//  Created by Do Trung Dung on 4/10/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var lblVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        detectDarkMode()
        detectVersion()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func detectVersion() {
        lblVersion.text = "\(Bundle.main.appName) v \(Bundle.main.versionNumber) (Build \(Bundle.main.buildNumber))"
    }
    
    func detectDarkMode() {
        let dark = DatabaseServices.sharedInstance.getDarkModeState()
        if (dark) {
            self.btnSwitch.setOn(true, animated: true)
            self.changeTheme(themeVal: "dark")
        } else {
            self.btnSwitch.setOn(false, animated: true)
            self.changeTheme(themeVal: "light")
        }
    }
    @IBAction func actionChangeMode(_ sender: Any) {
        if (btnSwitch.isOn) {
            self.changeTheme(themeVal: "dark")
        } else {
            self.changeTheme(themeVal: "light")
        }
    }
    
    func changeTheme(themeVal: String) {
        if #available(iOS 13.0, *) {
         switch themeVal {
         case "dark":
            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.overrideUserInterfaceStyle = .dark
            DatabaseServices.sharedInstance.saveDarkMode(state: true)
             break
         case "light":
            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.overrideUserInterfaceStyle = .light
            DatabaseServices.sharedInstance.saveDarkMode(state: false)
             break
         default:
            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.overrideUserInterfaceStyle = .unspecified
         }
      }
    }
    
}
