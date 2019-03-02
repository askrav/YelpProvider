import XCTest

extension CategoryTests {
    static let __allTests = [
            ("testCategoryParsedProperly", testCategoryParsedProperly),
            ("testCategoryResponseParsedProperly", testCategoryResponseParsedProperly),
            ("testCategoriesResponseParsedProperly", testCategoriesResponseParsedProperly),
        ]
}

extension EventTests {
    static let __allTests = [
            ("testEventParsedProperly", testEventParsedProperly),
        ]
}

extension BusinessTests {
    static let __allTests = [
            ("testBusinessParsedProperly", testBusinessParsedProperly),
        ]
}

extension ReviewTests {
    static let __allTests = [
            ("testReviewParsedProperly", testReviewParsedProperly),
        ]
}

extension AutocompleteTests {
    static let __allTests = [
            ("testAutocompleteParsedProperly", testAutocompleteParsedProperly),
        ]
}

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
         testCase(CategoryTests.__allTests),
         testCase(EventTests.__allTests),
         testCase(BusinessTests.__allTests),
         testCase(ReviewTests.__allTests),
         testCase(AutocompleteTests.__allTests),
    ]
}
#endif
