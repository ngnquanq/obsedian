## Failure happens
- Embrace failures - They will happen!
- How to avoid -> how to identify and what to do about it
- Operational concern -> developer concern
- Plan to be throttled
- Plan to retry (with exponential backoff)
- Degrade gracefully
- Cache when appropriate

## Retry patten
This enables an application to handle transient failures when it tries to connect to a service or a network resource, by transparently retrying and failing the operation.

Database first then application is a **fragile design**, which isn't appropriate for cloud native applications. If your database is not there, your applications should wait patiently and then retry again.
## Circuit breaker pattern
It is used to identify a problem and then do something about it to avoid cascading failures.

## Bulkhead pattern
This pattern can be used to isolate failing services to limit the scope of a failure

## Chaos engineering
- Also known as monkey testing
- You deliberately kill services
- Netflix created the simian army tools
- You cannot know how something will respond to a failure until it actually fails