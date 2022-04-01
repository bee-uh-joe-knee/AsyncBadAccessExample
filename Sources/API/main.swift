import Foundation
import AWSLambdaRuntime
import NIOCore


Lambda.run({ context -> EventLoopFuture<ByteBufferLambdaHandler> in
    let promise=context.eventLoop.makePromise(of: ByteBufferLambdaHandler.self)
    promise.completeWithTask {
        switch API.environment {
        case .production: return try await API(context: context)
        case .development: return try await DevelopmentAPI(context: context)
        }
    }
    return promise.futureResult
})
