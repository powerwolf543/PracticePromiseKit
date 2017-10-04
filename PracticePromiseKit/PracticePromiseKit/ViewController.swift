//
//  Created by NixonShih on 2017/9/17.
//  Copyright © 2017 NixonShih. All rights reserved.
//

import UIKit
import PromiseKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    private func performAsync() {
        
        let url = "https://github.com/"
        
        when(fulfilled: Network.perform(with: url), Mission.performHeavyTask())
            .then { (data, _) -> String in
                
                guard let str = String(data: data, encoding: .utf8) else {
                    throw NetworkError.ParseStringError
                }
                
                return str
            }
            .then { str -> Void in
                print(str)
            }
            .catch { (e) in
                print(e)
        }
    }
    
    private func performSerial() {
        
        let url = "https://github.com/"
        
        Network.perform(with: url)
            .then { _ in Network.perform(with: "https://github.com/1") }
            .then { _ in Network.perform(with: "https://github.com/2") }
            .then { _ in Network.perform(with: "https://github.com/3") }
            .catch { print($0) }
    }
    
    private func performNetworkTask() {
        
        let url = "https://github.com/"
        
        Network.perform(with: url)
            .then { (data) -> String in
                
                guard let str = String(data: data, encoding: .utf8) else {
                    throw NetworkError.ParseStringError
                }
                
                return str
            }
            .then { str -> Void in
                print(str)
            }
            .catch { (e) in
                print(e)
        }
    }
    
    private func performHeavyTask() {
        let _ = Mission.performHeavyTask().then { () -> Void in
            print("success")
        }
    }
}
