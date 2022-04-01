import NIOCore
import Foundation
import AWSLambdaRuntime
import AWSLambdaEvents


// TODO: Document.
public final class API: AsyncLambdaHandler {
    
    // `AsyncLambdaHandler` conformance
    public init(context: Lambda.InitializationContext) async throws {
        Self.shared=self
    }

    // `AsyncLambdaHandler` conformance
    public func handle(event: APIGateway.V2.Request, context: Lambda.Context) async throws -> APIGateway.V2.Response {
        
        /// executed as print statements weren't logging anything
        /// then `context.logger` was used instead, and the logging was working
        /// but also the print statements were working then too
        /// so `context.logger` is used once at the beginning of the invocation as a workaround to get print statements to appear in the logs
        context.logger.log(level: .info, "This log message exists purely as a workaround to get print statements to work properly.")
        
        // do `async` stuff
        return .init(statusCode: .ok, body: "It's working now!")
    }
    
    // `AsyncLambdaHandler` conformance
    public func handle(context: Lambda.Context, event: In) -> EventLoopFuture<Out> {
        let promise = context.eventLoop.makePromise(of: Out.self)
        promise.completeWithTask {
            try await self.handle(event: event, context: context)
        }
        return promise.futureResult
    }
    
    // TODO: Document
    internal static let environment: Environment=Environment(rawValue: ProcessInfo.processInfo.environment["ENVIRONMENT"]!)!
    
    // TODO: Document.
    internal private(set) static var shared: API!
    
    // TODO: Document
    internal enum Environment: String {
        case production, development
    }
    
    // `AsyncLambdaHandler` conformance.
    public typealias In=APIGateway.V2.Request
    
    // `AsyncLambdaHandler` conformance.
    public typealias Out=APIGateway.V2.Response
}
