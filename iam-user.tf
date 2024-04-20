locals {
  member_chiba = {
    email : var.chiba_gmail_username // if "abcdef@gmail.com", then "abcdef"
    roles : [
      "roles/editor"
    ]
  }

  member_suzuki = {
    email : var.suzuki_gmail_username // if "abcdef@gmail.com", then "abcdef"
    roles : [
      "roles/editor"
    ]
  }
}

resource "google_project_iam_member" "member_chiba" {
  for_each = toset(local.member_chiba.roles) // 指定したリストごとにメンバー・ロールのマッピングを行う
  project  = var.project
  member   = "user:${local.member_chiba.email}@gmail.com"
  role     = each.value
}

resource "google_project_iam_member" "member_suzuki" {
  for_each = toset(local.member_suzuki.roles) // 指定したリストごとにメンバー・ロールのマッピングを行う
  project  = var.project
  member   = "user:${local.member_suzuki.email}@gmail.com"
  role     = each.value
}
