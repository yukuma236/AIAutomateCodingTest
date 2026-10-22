# docs

このプロジェクト固有の要件・環境情報を格納します。

想定する内容例：

- 業務要件・BFC（Business Function Chart）
- ユースケース間依存関係表
- 機能一覧（フロー単位、機能ID付き）
- データフロー対応表
- 個別フロー処理仕様書（業務上の入力・処理・通知／応答・失敗時の動作）
- 対象環境情報（Developer/Sandbox/Productionの環境ID、既定接続参照等）
  → [`environments.sample.md`](./environments.sample.md)をコピーして`environments.md`として
  記入する（`environments.md`は`.gitignore`で除外済み。秘密情報は記入しない）
- Test Specification（`.yaml`、`standards/docs/test-case-schema.md`形式）

成果物は業務要件から始め、`standards/docs/README.md` と
`standards/.github/copilot-instructions.md` に定める作成順序に従ってください。
BFCは業務活動・ユースケース・機能の関係、処理仕様書は個別フローの業務動作、
データモデルは項目・型・関連を記述します。データモデルのみから業務ルールを推測して確定せず、
未決事項は明示して確認してください。Test Specification/Test Caseの期待結果は承認済み要件・仕様から導出します。

機能ID体系は`standards/docs/test-traceability-standard.md`に従ってください。ファイル構成はプロジェクトの規模に応じて設計してかまいません。
通知要件を整理する場合は、必要に応じて[`templates/notification-input-template.md`](./templates/notification-input-template.md)を利用してください。
この入力票は任意の情報収集用であり、全フローへの通知機能追加や通知フローの共通化を要求するものではありません。
