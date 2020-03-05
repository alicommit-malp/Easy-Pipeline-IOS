//
//  Pipeline.swift
//  easypipeline
//
//  Created by Developer on 4.03.2020.
//  Copyright © 2020 Ahmet. All rights reserved.
//

import Foundation

class Pipeline: WorkStation {
    private var pipelineResult: PipelineResultProtocol?
    private var requestCode: Int?
    
    init(pipelineResult: PipelineResultProtocol, requestCode: Int) {
        super.init()
        IsRoot = true
        self.requestCode = requestCode
        self.pipelineResult = pipelineResult
    }
    
    internal override func InvokeAsync(data: PipelineDataProtocol) {
        DispatchQueue.global().async {
            self.runInBackground(iPipelineData: data, completion: { requestCode, response  in
                self.pipelineResult?.OnResult(sourcePipelineHashCode: requestCode, pipelineData: response)
            })
        }
    }
    
    func runInBackground(iPipelineData: PipelineDataProtocol, completion: @escaping (Int, PipelineDataProtocol) -> Void) {
        super.InvokeAsync(data: iPipelineData)
        completion(requestCode!,iPipelineData)
    }
}

