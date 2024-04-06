resource "google_iam_custom_role" "912" {
  description = "作成日: 2024-02-23、ベース: サービス アカウント トークン作成者, サービス アカウント ユーザー"
  permissions = ["iam.serviceAccounts.actAs", "iam.serviceAccounts.get", "iam.serviceAccounts.getAccessToken", "iam.serviceAccounts.getOpenIdToken", "iam.serviceAccounts.implicitDelegation", "iam.serviceAccounts.list", "iam.serviceAccounts.signBlob", "iam.serviceAccounts.signJwt", "resourcemanager.projects.get"]
  project     = var.project
  role_id     = "912"
  title       = "サービスアカウント権限借用"
}
# terraform import google_iam_custom_role.912 912

