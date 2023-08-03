//
//  lifetimeStats.swift
//  GolfTracker
//
//  Created by Zac Coeur on 8/2/23.
//

import UIKit
//import RealmSwift

class lifetimeStats: UIViewController {
//    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

        // find all realm variables here. need handicap, total greens, total greens hit, total putts per hole, total fairways, total fairways hit
//        var totalPutts = 0
//        var totalHoles = 0
//        let roundList = realm.objects(Round.self)
//        for round in roundList{
//            totalPutts += round.putts ?? 0
//            totalHoles += round.totalHoles ?? 0
//        }
//        putts.text = "\(totalPutts/totalHoles)"
//        fairways.text = "\(totalPutts)"
//        handicap.text = "\(totalHoles)"
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
