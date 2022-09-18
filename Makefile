create_config: wipe
	xcodegen generate --spec Domain/project.yml --project Domain
	xcodegen generate --spec Data/project.yml --project Data
	xcodegen generate --spec Presentation/project.yml --project Presentation
wipe:
	rm -rf Domain/Domain.xcodeproj Domain/Info.plist
	rm -rf Data/Data.xcodeproj Data/Info.plist
	rm -rf Presentation/Presentation.xcodeproj Presentation/Info.plist
