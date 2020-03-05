//
//  WorkStation1.swift
//  easypipelineTests
//
//  Created by Developer on 4.03.2020.
//  Copyright © 2020 Ahmet. All rights reserved.
//

import Foundation

class WorkStation1: WorkStation {
    override func InvokeAsync(data: PipelineDataProtocol) {
        sleep(3)
        (data as! MyPipelineData).data.append("a")
        super.InvokeAsync(data: data)
    }
}

