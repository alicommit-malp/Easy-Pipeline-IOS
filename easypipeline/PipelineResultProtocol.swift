//
//  PipelineResultProtocol.swift
//  easypipeline
//
//  Created by Developer on 4.03.2020.
//  Copyright © 2020 Ahmet. All rights reserved.
//

import Foundation

protocol PipelineResultProtocol {
    func OnResult(sourcePipelineHashCode: Int, pipelineData: PipelineDataProtocol)
}
