//
//  FifthViewController.swift
//  GolfTracker
//
//  Created by Zac Coeur on 8/20/22.
//

import UIKit
import RealmSwift

class FifthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var roundTable: UITableView!
    
    let realm = try! Realm()
    //let roundList = realm.objects(Round.self)
    var roundCount = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        roundTable.delegate = self
        roundTable.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let roundList = realm.objects(Round.self)
        print("number of rows")
        print(roundList.count)
        return roundList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let roundList = realm.objects(Round.self)
        roundTable.deselectRow(at: indexPath, animated: true)
        let selectedRound = roundList[indexPath.row]
        Variables.totalFairways = selectedRound.totalFairways ?? -1
        Variables.strokes = Double(selectedRound.strokes ?? -1)
        Variables.greensHit = Double(selectedRound.greensHit ?? -1)
        Variables.putts = Double(selectedRound.putts ?? -1)
        Variables.totalHoles = selectedRound.totalHoles ?? -1
        Variables.fairwaysHit = Double(selectedRound.fairwaysHit ?? -1)
        performSegue(withIdentifier: "roundSegue", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let roundList = realm.objects(Round.self)
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:354, height:50))
        let testRoundName = roundList[indexPath.row].roundName ?? "<no-name>"
        let roundDate = roundList[indexPath.row].date ?? Date.now
        let roundHoles = roundList[indexPath.row].totalHoles
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let testDate = dateFormatter.string(from: roundDate)

        label.numberOfLines = 0
        label.text = "\(roundHoles ?? 18) holes at \(testRoundName) on \(testDate)"
        cell.addSubview(label)
        return cell
    }

    
    // UITableViewDelegate Functions

    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     
     
     
     class MyViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {

             @IBOutlet var tableInfoQuake: UITableView!

             override func viewDidLoad() {
                 super.viewDidLoad()

                 tableInfoQuake.datasource = self
                 tableInfoQuake.delegate = self
             }


             // UITableViewDataSource Functions

             func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                 return 7
             }

             func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
                 let cell = UITableViewCell()
                 let label = UILabel(CGRect(x:0, y:0, width:200, height:50))
                 label.text = "Hello Man"
                 cell.addSubview(label)
                 return cell
             }


             // UITableViewDelegate Functions

             func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
                 return 50
             }
         }
    */

}
