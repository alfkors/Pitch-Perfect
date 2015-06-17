//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Mykola Aleshchanov on 5/30/15.
//  Copyright (c) 2015 Mykola Aleshchanov. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    let filePathUrl: NSURL!
    let title: String!
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
