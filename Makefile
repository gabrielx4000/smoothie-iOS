test:
	xcodebuild clean test \
            -project Data/Data.xcodeproj \
            -scheme DataUnitTests \
            -derivedDataPath build \
            -destination "platform=iOS Simulator,name=iPhone 11" \
            -resultBundlePath ./build/data-test-results.xcresult
