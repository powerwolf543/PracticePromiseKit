//
//  Created by NixonShih on 2017/9/17.
//  Copyright © 2017年 NixonShih. All rights reserved.
//

import Foundation
import PromiseKit

struct Mission {
    
    static func performHeavyTask() -> Promise<Void> {
        
        let (promise, fulfill, _) = Promise<Void>.pending()
        
        func fs(n: Int) -> Int {
            return n > 1 ? fs(n: n - 1) + fs(n: n - 2) : n
        }
        
        DispatchQueue.global().async {
            
            var total = 0
            
            for i in 0...10 {
                total = total + fs(n: i)
            }
            
            print(total)
            
            fulfill(())
        }
        
        return promise
    }
}
