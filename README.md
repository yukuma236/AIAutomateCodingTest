# power-automate-project-template

Power Automateクラウドフロー開発で使用するチームテンプレートです。

GitHub Copilot CLI / Claude Codeと、Microsoft公式の **FlowAgent MCP Server**
（`microsoft/power-platform-skills` の `power-automate` プラグイン）を利用した
AI支援開発を前提としています。

> このテンプレートは [power-apps-project-template](https://github.com/k0003k/power-apps-project-template)
> の構成を参考に、Power Automate向けに独立して作成したものです。Power Appsテンプレート本体との
> 依存関係はありませんが、開発標準は [power-automate-standards](https://github.com/yukuma236/power-automate-standards)
> を Git submodule として参照する、同じ構成を採用しています。

## 前提セットアップ

1. GitHub Copilot CLIをインストールし、GitHubアカウントでログイン
2. マーケットプレイス登録 + プラグインインストール
   ```
   /plugin marketplace add microsoft/power-platform-skills
   /plugin install power-automate@power-platform-skills
   ```
3. Node.js 18以上、Azure CLI（`az login`）をセットアップ
4. Copilot CLI内で `setup` スキルを実行し、前提条件を確認
5. このテンプレートから新規リポジトリを作成した後、`standards/` submoduleを取得する
   ```powershell
   git clone --recurse-submodules <新規リポジトリURL>
   # 既にcloneしてしまい standards/ が空の場合
   ./scripts/update-standards.ps1
   ```

## ディレクトリ構成

```text
power-automate-project-template/
├── .github/
│   ├── copilot-instructions.md   # AI向け開発指示（Research→Plan→Implement）
│   ├── prompts/
│   │   ├── 1_task-research.prompt.md
│   │   ├── 2_task-plan.prompt.md
│   │   └── 3_task-implement.prompt.md
│   └── workflows/
│       └── solution-ci.yml        # ソリューションのビルド検証・環境デプロイCI/CD雛形
├── docs/                          # プロジェクト固有の要件・環境情報
├── scripts/
│   ├── update-standards.ps1       # standards/ submoduleの初期化・更新スクリプト
│   ├── export-solution.ps1        # ソリューションのexport・unpack
│   ├── pack-solution.ps1          # ソリューションのpack(Managed/Unmanaged)
│   └── import-solution.ps1        # ソリューションの対象環境へのimport
├── solutions/                     # ソリューション管理雛形（詳細はsolutions/README.md参照）
│   ├── src/                        # pac solution unpack の出力（ソース管理対象）
│   └── build/                      # pac solution pack の出力(.zip、git管理外)
├── src/
│   └── flows/                     # FlowAgent MCPでエクスポートしたフロー定義(JSON)のローカル控え
├── .gitmodules                     # standards submoduleの参照先定義
└── standards/                     # Power Automate開発標準（Git submodule、実体は別リポジトリ）
    ├── docs/
    │   ├── README.md
    │   ├── naming-conventions.md
    │   ├── power_automate_dev_standard.md
    │   ├── solution-management-standard.md
    │   ├── testing-standard.md            # Apps標準との共通部分＋Automate差分
    │   ├── test-traceability-standard.md  # Apps標準との共通部分＋Automate差分
    │   └── test-case-schema.md            # Apps標準との共通部分＋Automate差分
    └── samples/
```

`standards/` の実体は [power-automate-standards](https://github.com/yukuma236/power-automate-standards)
リポジトリであり、本テンプレートはそこへの参照（submodule）のみを保持します。

**現在参照しているバージョン：`v1.13.0`**（[CHANGELOG](https://github.com/yukuma236/power-automate-standards/blob/main/CHANGELOG.md)参照）

standardsを更新する場合は、最新コミットではなく特定のタグへ明示的に固定してください。

```powershell
cd standards
git fetch --tags
git checkout <新しいタグ>
cd ..
git add standards
git commit -m "standards: pin to <新しいタグ>"
```

### standardsの更新を検知する方法

- [power-automate-standards](https://github.com/yukuma236/power-automate-standards)で
  **Watch → Custom → Releases** を選択しておくと、新しいバージョンがリリースされた際に
  GitHub通知（メール／Web）を受け取れる
- 各プロジェクトの担当者は、少なくとも**月次**、またはReleaseに気づいた際に
  [`CHANGELOG.md`](https://github.com/yukuma236/power-automate-standards/blob/main/CHANGELOG.md)
  を確認し、submoduleを最新タグへ更新するか判断する
- 破壊的変更（メジャー・マイナーバージョンの変更）が含まれる場合は、影響範囲を確認してから更新する

## Power Platformが正

Power Platform（クラウドフロー本体）が常に正の状態です。`src/flows/` は
FlowAgent MCPの `get_flow` でエクスポートしたローカル控え（解析・レビュー・差分確認用）であり、
同期が取れていない場合は最新の状態とみなしません。

## 開発ワークフロー

非自明なタスクは、`.github/prompts/` の3段階ワークフローに従ってください。

1. Research（`1_task-research.prompt.md`）
2. Plan（`2_task-plan.prompt.md`）
3. Implement and Validate（`3_task-implement.prompt.md`）

## 開発標準

`standards/docs/README.md` を入り口として、タスクに関連する文書のみを確認してください。
全文書を一括で読み込む必要はありません。

## ソリューション管理

フロー・接続参照・環境変数をDeveloper → Sandbox → Productionへデプロイする手順は
[`solutions/README.md`](./solutions/README.md)および
[`standards/docs/solution-management-standard.md`](./standards/docs/solution-management-standard.md)
を参照してください。環境変数値ファイル（`*.settings.json`）やCI/CD実行用資格情報など、
秘密情報の扱いは同文書「2.4 秘密情報管理」を参照してください。
