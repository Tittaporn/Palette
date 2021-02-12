//
//  UnsplashPhoto.swift
//  Palette
//
//  Created by Cameron Stuart on 7/10/20.
//  Copyright © 2020 Cameron Stuart. All rights reserved.
//

import Foundation

struct PhotoSearchDictionary: Decodable {
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    
    let urls: URLGroup
    let description: String?
}

struct URLGroup: Decodable {
    let small: String
    let regular: String
}



/*
 
 https://imagga.com/profile/dashboard
 API Details:
 API Key:acc_5f19fdb345db651
 API Secret: acb6a7e3347dd74e817dc57daeb99941  new
 Authorization
 Basic YWNjXzVmMTlmZGIzNDVkYjY1MTphY2I2YTdlMzM0N2RkNzRlODE3ZGM1N2RhZWI5OTk0MQ==
 API Endpoint: https://api.imagga.com

 
 https://unsplash.com/oauth/applications/205590
 
 Access Key:
 
 PQ-nJ8V09zr0Fm-rj9Q5e8pTLDJNxohRy204CBLYrUo
 
 Secret key:
 M6mmq0eoovLWPxtToMqYz8X6teuvMSl1KVQD0XfnoJQ
 
 
 */
