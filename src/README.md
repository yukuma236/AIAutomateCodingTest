# src/flows

FlowAgent MCPの `get_flow` でエクスポートしたフロー定義JSONのローカル控えを格納します。

**Power Platform（対象環境）が常に正です。** このディレクトリのJSONは、AI支援開発・レビュー・
差分確認・ソース管理のための控えであり、同期が確認できない場合は最新状態とみなしません。

## 運用ルール

1. フローの調査・解析を行う前に、`flowagent-get_flow` で最新定義を取得し、このディレクトリを更新する
2. ファイル名はフロー名の機能ID（`standards/docs/naming-conventions.md`参照）を用いる

   ```text
   src/flows/AU001_交通費申請_自動登録.json
   src/flows/IF001_人事システム連携_従業員マスタ受信.json
   ```

3. フロー定義を直接手編集してアップロードし直すことはしない。`flowagent-edit_flow`（部分編集）
   または `flowagent-update_flow`（全体更新）を使用し、変更後に改めてエクスポートしてこの
   ディレクトリを更新する
4. 実装変更後は、このディレクトリの内容が実際のPower Platform状態と同期していることを確認する
