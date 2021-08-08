//
//  ViewModel.swift
//  DIAGNAL
//
//  Created by Aravind Kumar on 08/08/21.
//

import Foundation
class ContentViewModel :NSObject {
    enum ErrorS: Swift.Error {
        case fileNotFoundS(name: String)
    }
    
    var contentInfo:[ContentInformation]!
    //call back to update UI
    var onUpdateCall:(() -> Void)?
    override init() {
        super.init()
        self.contentInfo = [ContentInformation]()
    }
    //Get Data Accroding Page
    func callFuncToGetData(page:String) {
        let ssFileName = "CONTENTLISTINGPAGE-PAGE\(page)"
        if let fileURL = Bundle.main.url(forResource: ssFileName, withExtension: "json") {
            print(fileURL)
            print(ssFileName)
            let data =    try? Data(contentsOf: fileURL)
            if let json =   try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                self.contentInfo += self.parseData(dict: json)
                self.onUpdateCall?()
            }
            
        }
    }
    //Parse the Page Data
    func parseData(dict:[String:Any]) -> [ContentInformation] {
        var localContent = [ContentInformation]()
        if let page  = dict["page"] as? [String:Any] {
            if let contentItems = page["content-items"] as? [String:Any] {
                if let content = contentItems["content"] as? [Any] {
                    for items in content {
                        if let more = items as? [String:Any] {
                            if let name = more["name"] as? String {
                                if let posterImage = more["poster-image"] as? String {
                                    localContent.append(ContentInformation(name: name, poster: posterImage))
                                }
                            }
                            
                        }
                    }
                }
            }
        }
        return localContent
    }
}
