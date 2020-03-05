//
//  WorkStation2.swift
//  easypipelineTests
//
//  Created by Developer on 4.03.2020.
//  Copyright © 2020 Ahmet. All rights reserved.
//

import Foundation

class WorkStation2: WorkStation {
    override func InvokeAsync(data: PipelineDataProtocol) {
        sleep(3)
        (data as! MyPipelineData).data.append("b")
        super.InvokeAsync(data: data)
    }
}
