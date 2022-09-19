test:
	rm -rf build
	xcodebuild clean test \
            -workspace Smoothie.xcworkspace \
            -scheme Smoothie \
            -derivedDataPath build \
            -destination "platform=iOS Simulator,name=iPhone 11" \
            -resultBundlePath ./build/test-results.xcresult
