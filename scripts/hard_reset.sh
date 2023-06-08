flutter clean
cd ../ios
rm -rf Pods
rm -rf .symlinks
flutter pub get
arch -x86_64 pod repo update
arch -x86_64 pod install
cd ..
flutter pub get