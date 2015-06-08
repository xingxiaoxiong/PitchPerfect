//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by shapeare on 6/8/15.
//  Copyright (c) 2015 BettyBearStudio. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl:NSURL!, title:String!){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
