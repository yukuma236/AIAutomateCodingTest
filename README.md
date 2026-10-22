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
   .\scripts\update-standards.ps1
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
│   ├── update-standards.ps1       # standards/ submoduleを親リポジトリの固定コミットへ初期化
│   ├── export-solution.ps1        # ソリューションのexport・unpack
│   ├── pack-solution.ps1          # ソリューションのpack(Managed/Unmanaged)
│   └── import-solution.ps1        # ソリューションの対象環境へのimport
├── solutions/                     # ソリューション管理雛形（詳細はsolutions/README.md参照）
│   ├── src/                        # pac solution unpack の出力（ソース管理対象）
│   └── build/                      # pac solution pack の出力(.zip、git管理外)
├── src/
│   └── flows/                     # FlowAgent MCPでエクスポートしたフロー定義(JSON)のローカル控え
├── templates/
│   └── test-evidence-template.xlsx # テスト証跡Excelのひな形(standards/docs/testing-standard.md 5章準拠)
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

**現在参照しているバージョン：`v1.15.6`**（[`standards/`のgitlink](https://github.com/yukuma236/AIAutomateCodingTest/tree/main/standards)に対応。詳細は[CHANGELOG](https://github.com/yukuma236/power-automate-standards/blob/v1.15.6/CHANGELOG.md)参照）

`.\scripts\update-standards.ps1` は、現在の親リポジトリに記録されたgitlinkのコミットを初期化・取得するだけです。`standards/` を最新リリースへ自動更新するスクリプトではありません。

標準の取得とバージョン更新を区別してください。

- 新規clone後、または空のsubmoduleを初期化するとき：`.\scripts\update-standards.ps1` を実行します。親リポジトリが記録した固定コミットが取得されます。
- バージョン更新を承認して行うとき：まず変更内容と影響を確認し、明示したタグへ切り替えたうえで親リポジトリのgitlinkをコミットします。`main` の最新コミットへ追随させないでください。

```powershell
cd standards
git fetch --tags
git checkout <承認した新しいタグ>
cd ..
git add standards
git commit -m "standards: pin to <承認した新しいタグ>"
```

READMEのバージョン表記は、`standards/` のgitlinkが指すコミットのCHANGELOGに記載されたタグと一致させてください。

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

各工程の出力は、関連するプロジェクト文書として保存し、次のチャットではそのファイルパスと承認状態を明示して引き継ぎます。会話履歴だけに依存しないでください。Researchで業務仕様を確認・承認し、Planを承認してからImplementへ進みます。

これらの`.prompt.md`はリポジトリに置かれた再利用可能なプロンプト文書です。インストール済みSkillや特定のスラッシュコマンドとして扱わず、使用する工程のファイルを開いて内容をCLIまたはVS Codeのチャットに与えてください。PowerShellでは例として次のように内容を表示できます。

```powershell
Get-Content .github/prompts/1_task-research.prompt.md
```

Researchの最初の入力例：

```text
業務概要：申請を受け付け、条件に応じて担当者へ通知する。
既存資料：docs/requirements.md、docs/data-model.md
依頼：既存資料を再利用してResearchを開始し、確定事項と業務動作に影響する未決事項を分けてください。データモデルから業務ルールを推測確定せず、実装は始めないでください。
```

通知要件の整理には、任意の入力票[`docs/templates/notification-input-template.md`](./docs/templates/notification-input-template.md)を利用できます。全フローに通知を要求するものではありません。

テンプレート側のプロンプト／ガイド変更は、[power-automate-project-template commit `72da0bf6347f62d5888323efe30987bc56a01afe`](https://github.com/yukuma236/power-automate-project-template/commit/72da0bf6347f62d5888323efe30987bc56a01afe)を出典として、本プロジェクト固有の説明を保ちながら取り込んでいます。

## 開発標準

`standards/docs/README.md` を入り口として、タスクに関連する文書のみを確認してください。
全文書を一括で読み込む必要はありません。

## ソリューション管理

フロー・接続参照・環境変数をDeveloper → Sandbox → Productionへデプロイする手順は
[`solutions/README.md`](./solutions/README.md)および
[`standards/docs/solution-management-standard.md`](./standards/docs/solution-management-standard.md)
を参照してください。環境変数値ファイル（`*.settings.json`）やCI/CD実行用資格情報など、
秘密情報の扱いは同文書「2.4 秘密情報管理」を参照してください。

## テスト証跡（Excel）

新しいテストケースのExcel証跡を作成する際は、`docs/test-evidence/`配下の過去の実例ではなく、
必ず [`templates/test-evidence-template.xlsx`](./templates/test-evidence-template.xlsx) を
コピーして使用してください。[`standards/docs/testing-standard.md`](./standards/docs/testing-standard.md)
5章「Excel証跡のディシジョンテーブル形式」に準拠した、未記入のひな形です。

- **Test Spec**：対象フローの概要
- **Test Case**：Input条件×データパターンのディシジョンテーブル形式（期待結果・実績・判定・
  MC/DCによるパターン絞り込みの備考欄を含む）
- **エビデンス詳細**：Test Caseの「期待結果」全項目について、実行前後の実績値とOK/NG判定を
  1項目1行で記録する形式

作成済みのサンプルは `docs/test-evidence/` 配下を参照してください（これらは実データが入った
完成例であり、ひな形としてコピーする対象ではありません）。
