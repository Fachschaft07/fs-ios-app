//
//  RoomTableViewCell.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 27.05.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class RoomTableViewCell: UITableViewCell {

    var freeRoom: Room? {
        didSet{
            updateUI()
        }
    }
    
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var freeUntilLabel: UILabel!
   
    func updateUI(){
        typeLabel?.text = nil
        roomNameLabel?.text = nil
        freeUntilLabel?.text = nil
        
        if let freeRoom = self.freeRoom{
            typeLabel?.text = freeRoom.roomType ?? "err RoomType"
            roomNameLabel?.text = freeRoom.roomName ?? "err RoomName"
            freeUntilLabel?.text = freeRoom.freeUntil ?? "err freeUntil"
        }
    }
    
}
