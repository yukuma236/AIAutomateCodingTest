# solutions

Power Automateクラウドフロー・接続参照・環境変数を、Power Platformソリューション経由で
環境間（Developer → Sandbox → Production）にデプロイするための雛形です。

詳細な方針は、standards側の
[`solution-management-standard.md`](../standards/docs/solution-management-standard.md)を参照してください。

## フォルダ構成

```text
solutions/
├── README.md
├── src/                     # pac solution unpack の出力（ソース管理対象）
│   └── <solution-unique-name>/
│       ├── Other/
│       ├── Workflows/       # フロー定義(.json)がここに展開される
│       └── <solution-unique-name>.xml
└── build/                   # pac solution pack の出力(.zip)。ビルド成果物のためgit管理外
```

`src/`配下は空の状態（`.gitkeep`のみ）がデフォルトです。実際にソリューションを作成・exportした
時点で、`pac solution unpack`の出力がここに追加されます。

## 前提

- [Power Platform CLI (`pac`)](https://learn.microsoft.com/power-platform/developer/cli/introduction)
  がインストールされていること
- 対象環境に対して`pac auth create`で認証済みであること
- 対象環境（通常はDeveloper環境）に、フロー・接続参照・環境変数を含むソリューションが
  **メーカーポータル側で作成済み**であること（ソリューション自体の新規作成はAIツールの対象外）

## 基本フロー

1. メーカーポータルで対象ソリューションにフロー・接続参照・環境変数を追加する
   （AIにフロー編集を依頼する場合は、先にFlowAgent MCPでフロー自体を作成・編集し、
   その後にメーカーポータルで対象ソリューションへ追加する）
2. `scripts/export-solution.ps1` でソリューションをexport・unpackし、`solutions/src/`へ反映する
3. 差分をレビューし、コミットする
4. リリース時は `scripts/pack-solution.ps1` でmanaged solutionとしてpackし、
   `scripts/import-solution.ps1` で対象環境（Sandbox/Production）へimportする

CI/CDでの自動化例は [`.github/workflows/solution-ci.yml`](../.github/workflows/solution-ci.yml)
を参照してください。

## 秘密情報の取り扱い

- 環境変数値ファイル（`*.settings.json`、手順2.3参照）は秘密値を含み得るため`.gitignore`で
  除外しています。実際の値はコミットせず、手元またはCI/CDの実行環境にのみ存在させてください
- プレースホルダ値のみのサンプルを残したい場合は、`*.settings.sample.json`という別名で
  コミットしてください（`.gitignore`の例外対象）
- CI/CD実行用のサービスプリンシパル資格情報はGitHub Repository Secretsで管理します
  （詳細は[`solution-management-standard.md`2.4](../standards/docs/solution-management-standard.md)参照）
