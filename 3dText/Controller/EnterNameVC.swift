//
//  EnterNameVC.swift
//  3dText
//
//  Created by Shashank Pandya on 27/04/21.
//

import UIKit

class EnterNameVC: UIViewController {

    @IBOutlet weak var txtEnterYourName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTapMagic(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
        vc.showText = txtEnterYourName.text!
        self.navigationController?.pushViewController(vc, animated: true)
        self.txtEnterYourName.text = ""
    }
    

}
