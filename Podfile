source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

target "Cosmos" do
    pod 'RxSwift', '~> 3.0.0-beta.2'
    pod 'RxCocoa', '~> 3.0.0-beta.2'
    pod 'PureLayout', '~> 3.0.2'
    pod 'RealmSwift', '~> 2.0.2'

    target 'CosmosTests' do
        inherit! :search_paths
        pod 'Nimble', '~> 5.0.0'
    end
end
