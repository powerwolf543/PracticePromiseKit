//
//  Created by NixonShih on 2017/9/21.
//  Copyright © 2017 NixonShih. All rights reserved.
//

import UIKit

class ViewControllerTwo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.popViewController(animated: true)
        
        performNetworkTask()
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
            .then { [weak self] str -> Void in
                print("Success")
                guard let sSelf = self else { return }
                let alert = UIAlertController(title: "", message: str, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                sSelf.present(alert, animated: true, completion: nil)
            }
            .catch { [weak self] (e) in
                print("fail")
                guard let sSelf = self else { return }
                let alert = UIAlertController(title: "", message: e.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                sSelf.present(alert, animated: true, completion: nil)
        }
    }
}
