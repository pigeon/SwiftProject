/*
Copyright (c) 2015 Francesco Petrungaro. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY Francesco Petrungaro `AS IS' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
EVENT SHALL Francesco Petrungaro OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import UIKit
import NotificationCenter
import MyFramework

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var labelTemperature: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.labelTemperature.text = "Loading Temperature.."
        
        self.preferredContentSize = CGSizeMake(CGRectGetWidth(self.view.frame), 50)
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        weak var weakSelf : TodayViewController? = self
        
        NetworkManager.sharedInstance.fetchTemperature { (temperature) -> Void in
            
            if let strongSelf = weakSelf {
                
                if let currentTemperature = temperature {
                    strongSelf.labelTemperature.text = "Current Temp = \(currentTemperature)"
                    completionHandler(NCUpdateResult.NewData)
                }
                else{
                    strongSelf.labelTemperature.text = "Uknown Temperature"
                    completionHandler(NCUpdateResult.NoData)
                }
            }
        }
    }
}
