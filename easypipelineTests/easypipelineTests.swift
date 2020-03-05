//
//  easypipelineTests.swift
//  easypipelineTests
//
//  Created by Developer on 4.03.2020.
//  Copyright © 2020 Ahmet. All rights reserved.
//

import XCTest
@testable import easypipeline

class easypipelineTests: XCTestCase {
    
    var expecResponse: XCTestExpectation?
    var expecReqCode1: XCTestExpectation?
    var expecReqCode2: XCTestExpectation?
    
    var pipelineData: PipelineData?
    static var ReqCode: Int?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.pipelineData = nil
        easypipelineTests.ReqCode = nil
        self.expecReqCode1 = nil
        self.expecReqCode2 = nil
        self.expecResponse = nil
    }

    //MARK: Pipeline general test
    func testEasyPipeline() {
        self.expecResponse = expectation(description: "The expected response is 'ab' by data")
        let pipelineData = MyPipelineData()
        easypipelineTests.ReqCode = 1
        
        Pipeline(pipelineResult: self, requestCode: easypipelineTests.ReqCode!)
            .Next(workStation: WorkStation1())
            .Next(workStation: WorkStation2())
            .Run(data: pipelineData)
        
        wait(for: [expecResponse!], timeout: 8.0)
        
        XCTAssertEqual(pipelineData.data, "ab")
    }
   
    //MARK: Pipeline async test
    func test2EasyPipeline() {
        self.expecResponse = expectation(description: "The expected response is 'ab' by data")
        //first Pipeline
        let pipelineData1 = MyPipelineData()
        easypipelineTests.ReqCode = 1
        
        Pipeline(pipelineResult: self, requestCode: easypipelineTests.ReqCode!)
            .Next(workStation: WorkStation1())
            .Next(workStation: WorkStation2())
            .Run(data: pipelineData1)
        
        //second Pipeline
        let pipelineData2 = MyPipelineData()
        easypipelineTests.ReqCode = 2
        
        Pipeline(pipelineResult: self, requestCode: easypipelineTests.ReqCode!)
            .Next(workStation: WorkStation1())
            .Next(workStation: WorkStation2())
            .Run(data: pipelineData2)
        
        wait(for: [expecResponse!], timeout: 8.0)
    }
    
    //MARK: test request code for 1
    func testRequestCode1() {
        self.expecReqCode1 = expectation(description: "The expected response is '1' by request code")
        
        let pipelineData = MyPipelineData()
        easypipelineTests.ReqCode = 1
        
        Pipeline(pipelineResult: self, requestCode: easypipelineTests.ReqCode!)
            .Next(workStation: WorkStation1())
            .Next(workStation: WorkStation2())
            .Run(data: pipelineData)
        
        wait(for: [expecReqCode1!], timeout: 8.0)
    }
    
    //MARK: test request code for 2
    func testRequestCode2() {
        self.expecReqCode2 = expectation(description: "The expected response is '2' by request code")
        
        let pipelineData = MyPipelineData()
        easypipelineTests.ReqCode = 2
        
        Pipeline(pipelineResult: self, requestCode: easypipelineTests.ReqCode!)
            .Next(workStation: WorkStation1())
            .Next(workStation: WorkStation2())
            .Run(data: pipelineData)
        
        wait(for: [expecReqCode2!], timeout: 8.0)
    }
    
}

extension easypipelineTests: PipelineResultProtocol {
    func OnResult(sourcePipelineHashCode: Int, pipelineData: PipelineDataProtocol) {
        //Response expectation
        expecResponse?.fulfill()
        //Request code expectation for 1
        if sourcePipelineHashCode == 1 {
            expecReqCode1?.fulfill()
        }
        
        //Request code expectation for 2
        if sourcePipelineHashCode == 2 {
            expecReqCode2?.fulfill()
        }
    }
}
