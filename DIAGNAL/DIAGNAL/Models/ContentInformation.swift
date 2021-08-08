//
//  ContentInformation.swift
//  DIAGNAL
//
//  Created by Aravind Kumar on 08/08/21.
//

import Foundation

struct ContentInformation {
    var name:String = ""
    var posterImage:String = ""
    init(name:String,poster:String) {
        self.name = name
        self.posterImage = poster
    }
}
