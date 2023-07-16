//
//  FourthViewController.swift
//  GolfTracker
//
//  Created by Zac Coeur on 8/9/22.
//

import UIKit

class FourthViewController: UIViewController {

    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var scoreLabelNoChange: UILabel!
    
    @IBOutlet weak var puttLabel: UILabel!
    
    @IBOutlet weak var puttLabelNoChange: UILabel!
    
    @IBOutlet weak var fairwayLabel: UILabel!
    
    @IBOutlet weak var fairwayLabelNoChange: UILabel!
    
    @IBOutlet weak var greenLabel: UILabel!
    
    @IBOutlet weak var greenLabelNoChange: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(Int(Variables.strokes))"
        puttLabel.text = "\(Int(Variables.putts))"
        fairwayLabel.text = "\(Int(Variables.fairwaysHit))/\(Variables.totalFairways)"
        greenLabel.text =
            "\(Int(Variables.greensHit))/\(Variables.totalHoles)"
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
