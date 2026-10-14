# 対象環境情報（サンプル）

このファイルをコピーして `environments.md` として同じフォルダに保存し、実際の値を記入する
（`environments.md`自体は`.gitignore`で除外されるため、実際の値を記入したファイルはコミットされない）。

Environment ID・Environment URL自体は秘密情報ではないが、接続情報・テナント固有情報と
組み合わさることで攻撃対象の特定につながり得るため、本テンプレート（サンプル）のみを
ソース管理の対象とする。

| 項目 | Developer | Sandbox | Production |
| --- | --- | --- | --- |
| 環境名 | `<環境の表示名>` | `<環境の表示名>` | `<環境の表示名>` |
| Environment ID | `<GUID>` | `<GUID>` | `<GUID>` |
| Environment URL | `<https://xxxxxxxxxxxxxxxxxxxxxxx.crmXX.dynamics.com>` | `<...>` | `<...>` |
| リージョン | `<例：Japan>` | `<...>` | `<...>` |
| 用途 | 個人開発・単体試験 | 結合試験・UAT | 本番運用 |
| ソリューション種別 | Unmanaged | Managed | Managed |
| 既定接続のオーナー | 開発者個人アカウント | サービスプリンシパル（SPN） | サービスプリンシパル（SPN） |
| デプロイ方法 | 手動（`pac solution export`） | CI/CD（`solution-ci.yml`、手動承認） | CI/CD（`solution-ci.yml`、手動承認） |
| 環境管理者・連絡先 | `<担当者名>` | `<担当者名>` | `<担当者名>` |
| 備考 | | | |

## 関連

- CI/CDからの対象環境指定は`.github/workflows/solution-ci.yml`の`target_environment_url`
  （workflow_dispatch入力）で行う。実際のURLは、このファイルの「Environment URL」を参照する
- 接続参照の実体（Connection）の割り当ては、環境ごとに
  [`standards/docs/solution-management-standard.md`2.2](https://github.com/yukuma236/power-automate-standards/blob/main/docs/solution-management-standard.md)
  に従う
- APIキー等の秘密情報自体は、このファイルに記載せず
  [`standards/docs/solution-management-standard.md`2.4](https://github.com/yukuma236/power-automate-standards/blob/main/docs/solution-management-standard.md)
  の方針（環境変数のSecret型、GitHub Repository Secrets等）で管理する
