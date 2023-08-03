//
//  lifetimeStats.swift
//  GolfTracker
//
//  Created by Zac Coeur on 8/2/23.
//

import UIKit

class lifetimeStats: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // find all realm variables here. need handicap, total greens, total greens hit, total putts per hole, total fairways, total fairways hit
    }
    
    @IBOutlet weak var handicap: UILabel!
    
    @IBOutlet weak var putts: UILabel!
    @IBOutlet weak var fairways: UILabel!
    @IBOutlet weak var greens: UILabel!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
