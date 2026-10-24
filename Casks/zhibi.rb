cask "zhibi" do
  version "0.1.0"
  sha256 "b7770f3c4597cd5edf15453a5316668dc0cee79585439db6bcbe09938b366902"

  url "https://github.com/ElvisLabs/zhibi/releases/download/v#{version}/Zhibi-#{version}.zip"
  name "执笔"
  name "Zhibi"
  desc "AI reply drafting pane for the new Outlook"
  homepage "https://github.com/ElvisLabs/zhibi"

  depends_on macos: :sonoma

  app "Zhibi.app", target: "执笔.app"

  # Not notarized: without this Gatekeeper blocks the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/执笔.app"]
  end

  uninstall quit: "com.elvis.outlook-ai"

  zap trash: [
    "~/Library/Application Support/Zhibi",
    "~/Library/Caches/Zhibi",
    "~/Library/Logs/Zhibi",
    "~/Library/Preferences/com.elvis.outlook-ai.plist",
  ]

  caveats <<~EOS
    执笔还需要：
      - Python 版 outlook-cli，并登录 Exchange 邮箱：
          pipx install git+https://github.com/fatecannotbealtered/outlook-cli.git
      - Claude Code，在终端运行一次 claude 登录（或在执笔设置里填 Anthropic API Key）

    首次打开时，在「系统设置 → 隐私与安全性 → 辅助功能」里允许执笔。
    升级后如果按钮不出现，在该列表里删掉执笔，再打开执笔重新允许。
  EOS
end
