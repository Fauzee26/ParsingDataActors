//
//  ViewController.swift
//  ParsingDataActors
//
//  Created by Muhammad Hilmy Fauzi on 3/11/17.
//  Copyright © 2017 Hilmy Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelBirth: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var labelHeight: UILabel!
    @IBOutlet weak var labelSpouse: UILabel!
    @IBOutlet weak var labelChildren: UILabel!
    @IBOutlet weak var labelDescription: UILabel!

    var passName:String?
    var passBirth:String?
    var passCountry:String?
    var passHeight:String?
    var passSpouse:String?
    var passChildren:String?
    var passDescription:String?

    
    override func viewDidLoad() {
        
        labelName.text = passName!
        labelBirth.text = passBirth!
        labelCountry.text = passCountry!
        labelHeight.text = passHeight!
        labelSpouse.text = passSpouse!
        labelChildren.text = passChildren!
        labelDescription.text = passDescription!

        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

