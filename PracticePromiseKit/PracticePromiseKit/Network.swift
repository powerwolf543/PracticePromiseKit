//
//  Created by NixonShih on 2017/9/17.
//  Copyright © 2017年 NixonShih. All rights reserved.
//

import Foundation
import PromiseKit

enum NetworkError: Error {
    case ParseStringError
    case RequestError
}

struct Network {
    
    static func perform(with url: String) -> Promise<Data> {
        
        let (promise, fulfill, reject) = Promise<Data>.pending()
        
        guard let url = URL(string: url) else {
            reject(NetworkError.RequestError)
            return promise
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                reject(error)
                return
            }
            
            if let data = data { fulfill(data) }
        }
        
        task.resume()
        
        return promise
    }
}
