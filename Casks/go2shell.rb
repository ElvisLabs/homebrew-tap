cask "go2shell" do
  version "1.2.0"
  sha256 "70a935be98abd708294a04977e2805984066ace10796f3a6551e3bdbf4c3168c"

  url "https://github.com/ElvisLabs/go2shell/releases/download/v#{version}/go2shell.zip"
  name "go2shell"
  desc "Open terminal from Finder toolbar — fork with FinderSync extensions"
  homepage "https://github.com/ElvisLabs/go2shell"

  depends_on macos: ">= :sequoia"

  app "go2shell.app"

  caveats do
    <<~EOS
      go2shell is not notarized. On first launch, macOS Gatekeeper may block it.
      To allow it, run:
        xattr -d com.apple.quarantine /Applications/go2shell.app

      Or go to System Settings > Privacy & Security > click "Open Anyway".

      Then drag /Applications/go2shell.app into any Finder window's toolbar
      while holding ⌘ (Command). You'll also need to enable the two FinderSync
      extensions in System Settings > General > Login Items & Extensions.
    EOS
  end

  zap trash: [
    "~/Library/Preferences/com.solarhell.go2shell.plist",
    "~/Library/Group Containers/group.com.solarhell.go2shell",
  ]
end
