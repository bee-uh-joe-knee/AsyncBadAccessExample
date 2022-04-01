import NIOCore
import AWSLambdaEvents
import AWSLambdaRuntime
import Foundation


// TODO: Document.
internal final class DevelopmentAPI: AsyncLambdaHandler {
    
    // TODO: Document.
    private let api: API
    
    // `AsyncLambdaHandler` conformance
    internal init(context: Lambda.InitializationContext) async throws {
        self.api=try await .init(context: context)
    }

    // `AsyncLambdaHandler` conformance
    public func handle(event: APIGateway.V2.Request, context: Lambda.Context) async throws -> String {
        return try await self.api.handle(event: event, context: context).body!
    }
    
    // `AsyncLambdaHandler` conformance
    public func handle(context: Lambda.Context, event: In) -> EventLoopFuture<Out> {
        let promise = context.eventLoop.makePromise(of: Out.self)
        promise.completeWithTask {
            try await self.handle(event: event, context: context)
        }
        return promise.futureResult
    }
    
    // `AsyncLambdaHandler` conformance
    public typealias In=APIGateway.V2.Request
    
    // `AsyncLambdaHandler` conformance
    public typealias Out=String
    
}
