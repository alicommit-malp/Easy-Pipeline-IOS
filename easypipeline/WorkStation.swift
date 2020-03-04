//
//  WorkStation.swift
//  easypipeline
//
//  Created by Developer on 4.03.2020.
//  Copyright © 2020 Ahmet. All rights reserved.
//

import Foundation

class WorkStation {
    private var _nextWorkStation: WorkStation?
    private var _prevWorkStation: WorkStation?
    internal var IsRoot = false
    
    public func Next(workStation: WorkStation) -> WorkStation {
        _nextWorkStation = workStation
        _nextWorkStation?._prevWorkStation = self
        return _nextWorkStation!
    }
    
    public func Run(data: PipelineDataProtocol) {
        if IsRoot  {
            InvokeAsync(data: data)
        }else {
            _prevWorkStation?.Run(data: data)
        }
    }
    
    internal func InvokeAsync(data: PipelineDataProtocol) {
        if _nextWorkStation != nil {
            _nextWorkStation?.InvokeAsync(data: data)
        }
    }
}

