cask "zhibi" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.0"
  sha256 arm:   "14257a345bba597ecded1e7589622d80c4bc77d2b3825eba6a12f3892b55977e",
         intel: "64c43d746f13919c222e1037cc694ec767f5b309a0f36666847b7e226384d00a"

  url "https://github.com/ElvisLabs/zhibi/releases/download/v#{version}/Zhibi-#{version}-#{arch}.zip"
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
    第一次使用：
      1. 打开执笔，在「系统设置 → 隐私与安全性 → 辅助功能」里允许它
      2. 在 Outlook 里点执笔按钮 → 右上角齿轮 →「邮箱账号」登录 Exchange 邮箱
      3. 安装 Claude Code，在终端运行一次 claude 登录（或在执笔设置里填 Anthropic API Key）

    升级后如果按钮不出现，在辅助功能列表里删掉执笔，再打开执笔重新允许。
  EOS
end
