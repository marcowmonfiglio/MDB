//
//  RollCallVC.swift
//  CalHacksDemo
//
//  Created by Michael Lin on 8/26/20.
//  Copyright © 2020 Michael Lin. All rights reserved.
//

import UIKit

class RollCallVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
            
    
    @IBOutlet weak var presentButton: UIButton! {
        didSet { //Property observer; when label is set, the code will run in block
            var config = UIButton.Configuration.tinted()
            config.title = "Present"
            config.image = UIImage(systemName: "checkmark.circle.circle") //If a photo in assets, use name: "name_in_assets"
            config.baseForegroundColor = .systemGreen //UIColor part can be inferred
            config.baseBackgroundColor = .systemGreen
            config.imagePadding = 10
            config.buttonSize = .large
            presentButton.configuration = config
            presentButton.addAction(UIAction(handler: { [unowned self] _ in
                Roster.main.addName(toPresent: self.currentName)
                self.showNextNameOrResult()
            }), for: .touchUpInside) //UIControl is inferred so only the dot method is needed
        }
    
    //willSet {Before a property is actually assigned
    //}
    }
    
    @IBOutlet weak var absentButton: UIButton! {
        didSet { //Property observer; when label is set, the code will run in block
            var config = UIButton.Configuration.tinted()
            config.title = "Absent"
            config.image = UIImage(systemName: "xmark.circle.circle") //If a photo in assets, use name: "name_in_assets"
            config.baseForegroundColor = .systemRed
            config.baseBackgroundColor = .systemRed
            config.imagePadding = 10
            config.buttonSize = .large
            absentButton.configuration = config
            absentButton.addAction(UIAction(handler: { [unowned self] _ in
                Roster.main.addName(toAbsent: self.currentName)
                self.showNextNameOrResult()
            }), for: .touchUpInside)
            
            
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameLabel.text = Roster.main.getNextName()
        
    }
    
    var currentName: String! { //whenever currentName is requested, the computation in body is performed; read-only without get/set form
        get {
            return nameLabel.text
        }
    }
    
    private func showNextNameOrResult() {
        if let name = Roster.main.getNextName() {
            setUserInteractionEnabled(to: false)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.nameLabel.alpha = 0
            }, completion: { _ in
                self.nameLabel.text = name
                self.setUserInteractionEnabled(to: true)
                UIView.animate(withDuration: 0.3, animations: {
                    self.nameLabel.alpha = 1
                })
            })
        } else {
            performSegue(withIdentifier: "toResults", sender: nil) //comes from the storyboard transition
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ResultVC //down cast as a ResultVC insead of the superclass of UIViewController
    }

    private func setUserInteractionEnabled(to value: Bool) {
        presentButton.isUserInteractionEnabled = value
        absentButton.isUserInteractionEnabled = value
    }
}
