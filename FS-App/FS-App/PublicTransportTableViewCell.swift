//
//  PublicTransportTableViewCell.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 30.06.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class PublicTransportTableViewCell: UITableViewCell {

    var publicTransport: PublicTransport? {
        didSet{
            updateUI()
        }
    }
    
    
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var depatureLabel: UILabel!
   
   
    
    func updateUI(){
        lineLabel?.text = nil
        destinationLabel?.text = nil
        depatureLabel?.text = nil
        
        if let publicTransport = self.publicTransport{
            lineLabel?.text = publicTransport.line ?? "err line"
            destinationLabel?.text = publicTransport.destination ?? "err destination"
            depatureLabel?.text = publicTransport.depature ?? "err depature"
        }
    }


}
