//
//  SettingsViewController.swift
//  Keepjogging
//
//  Created by Ryan Handoyo on 4/16/22.
//

import UIKit

class SettingsViewController: UIViewController {


    // lanagage change
    @IBAction func changeLanguage(_ sender: UISegmentedControl) {
     
        switch sender.selectedSegmentIndex
            {
            case 0:
            UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            case 1:
            UserDefaults.standard.set(["zh-Hans"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            default:
                break
            }
            
        let alert = UIAlertController(title: "Notice", message: "Please restart the app to change the language. 请重启应用来切换语言。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)


    }
    override func viewDidLoad() {



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
