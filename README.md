# Asynchronous Easy pipeline in iOS

Lets suppose the following logic in an iOS Application  

- WorkStation1
- WorkStation2

We know that we have to take care of all these operations in separate thread. 

>Find the source code [here](https://github.com/alicommit-malp/Easy-Pipeline-IOS)


## Easy-Pipeline 
will take care of the above example as easy as the following code

```swift

Pipeline(pipelineResult: self, requestCode: easypipelineTests.ReqCode!)
    .Next(workStation: WorkStation1())
    .Next(workStation: WorkStation2())
    .Run(data: pipelineData)


```

## PipelineData 
is the object which will travel through all the Workstations 


```swift

class PipelineData: PipelineDataProtocol {
    //have your properties here
}

```

## Workstation 
A step in a pipeline, in the above example Call_API_A() is a workstation 


```swift

class WorkStation1: WorkStation {
    override func InvokeAsync(data: PipelineDataProtocol) {
        sleep(3)
        (data as! MyPipelineData).data.append("a")
        super.InvokeAsync(data: data)
    }
}

class WorkStation2: WorkStation {
    override func InvokeAsync(data: PipelineDataProtocol) {
        sleep(3)
        (data as! MyPipelineData).data.append("b")
        super.InvokeAsync(data: data)
    }
}

```

therefore for each step or workstation you will create a class which must inherit from the WorkStation class and the PipelineData object will be available to it.

## Request Code
is an integer which you need to provide the pipeline with, to be able to handle the pipeline's tasks asynchronous, therefore when the pipeline finishes its work ,means that the last workstation has finished its work then the pipeline will call its callback with its request code , therefore you can have multiple pipelines in one class. 


## Complete code 

```swift


class easypipelineTests: XCTestCase {
    
    var expecResponse: XCTestExpectation?
   
    var pipelineData: PipelineData?
    static var ReqCode: Int?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.expecResponse = expectation(description: "The expected response is 'ab' by data")
        easypipelineTests.ReqCode = 1
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        easypipelineTests.ReqCode = nil
        self.expecResponse = nil
    }

    //MARK: Pipeline general test
    func testEasyPipeline() {        
        let pipelineData = MyPipelineData()

        Pipeline(pipelineResult: self, requestCode: easypipelineTests.ReqCode!)
            .Next(workStation: WorkStation1())
            .Next(workStation: WorkStation2())
            .Run(data: pipelineData)
        
        wait(for: [expecResponse!], timeout: 8.0)
        
        XCTAssertEqual(pipelineData.data, "ab")
    }
}

extension easypipelineTests: PipelineResultProtocol {
    func OnResult(sourcePipelineHashCode: Int, pipelineData: PipelineDataProtocol) {
        //Response expectation
        expecResponse?.fulfill()
    }
}


```

Happy coding :)


>Find the source code [here](https://github.com/alicommit-malp/Easy-Pipeline-IOS)
