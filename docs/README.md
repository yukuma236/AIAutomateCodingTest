# docs

このプロジェクト固有の要件・環境情報を格納します。

想定する内容例：

- 業務要件・BFC（Business Function Chart）
- ユースケース間依存関係表
- 機能一覧（フロー単位、機能ID付き）
- データフロー対応表
- 対象環境情報（Developer/Sandbox/Productionの環境ID、既定接続参照等）
  → [`environments.sample.md`](./environments.sample.md)をコピーして`environments.md`として
  記入する（`environments.md`は`.gitignore`で除外済み。秘密情報は記入しない）
- Test Specification（`.yaml`、`standards/docs/test-case-schema.md`形式）

ファイル構成はプロジェクトの規模に応じて自由に設計してよいが、
`standards/docs/test-traceability-standard.md` のID体系・成果物作成順序に従うこと。
