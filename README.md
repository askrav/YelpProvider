# YelpProvider

![Swift](http://img.shields.io/badge/swift-4.2-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-3.0-brightgreen.svg)

[Yelp][yelp_home] is a local-search service that helps people find local businesses like dentists, hair stylists and mechanics.

## How To Use
In your `Package.swift` file, add the following

~~~~swift
.package(url: "https://github.com/askrav/YelpProvider.git", from: "1.0.0")
~~~~

Register the config and the provider in `configure.swift`
~~~~swift
let yelpConfig = YelpConfig(apiKey: "YOUR_API_KEY")
services.register(yelpConfig)
try services.register(YelpProvider())
~~~~


And this is it. Now let's see an example:
~~~swift
static func listCategories(_ req: Request) throws -> Future<Response> {
        return try req.make(YelpClient.self).categories.getCategories().flatMap { res in
            let categories = res.categories
            // ...
            // Do whatever you need to
            // ...
            
            return try res.encode(for: req)
        }
    }
~~~


All the documentation is available on the [Yelp API][yelp_api] website.


Yelp Provider is available under the MIT license. See the [LICENSE](LICENSE) file for more info.


[yelp_home]: https://www.yelp.com "Yelp"
[yelp_api]: https://www.yelp.com/developers/documentation/v3/get_started "Yelp API"