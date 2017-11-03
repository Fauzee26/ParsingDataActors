//
//  ViewTableViewController.swift
//  ParsingDataActors
//
//  Created by Muhammad Hilmy Fauzi on 3/11/17.
//  Copyright © 2017 Hilmy Corp. All rights reserved.
//

import UIKit

class ViewTableViewController: UITableViewController {

    let ActorURL = "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors"
    var actors = [Actor]()
    var nameSelected:String?
    var descriptionSelected:String?
    var birthSelected:String?
    var countrySelected:String?
    var heightSelected:String?
    var spouseSelected:String?
    var childrenSelected:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        getActor()
        //self sizing cells
        //set row height to 92
        tableView.estimatedRowHeight = 92.0
        //set row table height to automatic dimension
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return actors.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell

        cell.lblActor.text = actors[indexPath.row].name
        cell.lblCountry.text = actors[indexPath.row].country
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //mengecek data yang dikirim
        let dataTask = actors[indexPath.row]
        //memasukan data ke variable namaSelected dan image selected ke masing masing variable nya
        nameSelected = dataTask.name
        descriptionSelected = dataTask.description
        birthSelected = dataTask.birth
        countrySelected = dataTask.country
        heightSelected = dataTask.height
        spouseSelected = dataTask.spouse
        childrenSelected = dataTask.children
        //memamnggil segue passDataDetail
        performSegue(withIdentifier: "segue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //mengecek apakah segue nya ada atau  tidak
        if segue.identifier == "segue"{
            //kondisi ketika segue nya ada
            //mengirimkan data ke detailViewController
            let sendData = segue.destination as! ViewController
            sendData.passName = nameSelected
            sendData.passDescription = descriptionSelected
            sendData.passBirth = birthSelected
            sendData.passCountry = countrySelected
            sendData.passHeight = heightSelected
            sendData.passSpouse = spouseSelected
            sendData.passChildren = childrenSelected

        }
    }
    //MARK : - JSON Parsing
    //create new method with name : getLatestLoans()
    func getActor() {
        guard let actorurl = URL(string: ActorURL) else {
            return //this return is for back up the value that got when call variable loanURL
        }
        
        //declare request for request URL loanUrl
        let request = URLRequest(url: actorurl)
        //declare task for take data from variable request above
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            //check what error is available or not
            if let error = error {
                //condition when error
                //print error
                print(error)
                return //back up value error that we get
            }
            //parse JSON data
            //declare variable data to call data
            if let data = data {
                //for this part will call method parseJsonData that we will make in below
                self.actors = self.parseJsonData(data: data)
                
                //reload tableView
                OperationQueue.main.addOperation({
                    //reload data again
                    self.tableView.reloadData()
                })
            }
        })
        //task will resume to call the json data
        task.resume()
    }
    //create new method with name ParseJsonData
    //this method will parsing data Json
    func parseJsonData(data: Data) -> [Actor] {
        //declare variable loans as object from loans class
        var actors = [Actor]()
        //will repeat to json data that parsed
        do{
            //declare jsonResult for take data from the json
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            //parse json data
            //declare jsonLoans for call data array jsonResult with name Loans
            let jsonLoans = jsonResult?["actors"] as! [AnyObject]
            //will call data be repeated for jsonLoan have data json array from variable jsonLoans
            for jsonLoan in jsonLoans {
                //declare loan as object from class loan
                let AcToR = Actor()
                //enter the value to each object from class loan
                AcToR.name = jsonLoan["name"] as! String
                AcToR.description = jsonLoan["description"] as! String
                AcToR.birth = jsonLoan["dob"] as! String
                AcToR.country = jsonLoan["country"] as! String
                AcToR.height = jsonLoan["height"] as! String
                AcToR.spouse = jsonLoan["spouse"] as! String
                AcToR.children = jsonLoan["children"] as! String
                //process enter data to object
                actors.append(AcToR)
            }
        }catch{
            print(error)
        }
        return actors
    }
}
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


