resource "azurerm_policy_definition" "disallow_Standard_RAGRS_storage" {
  name                = var.policy_definition_name
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = var.policy_display_name
  description         = var.policy_description
  management_group_id = var.management_group_id

  metadata = jsonencode({
    version  = "1.0.0"
    category = "Storage"
  })

  // Define the policy rule based on the policy effect
  policy_rule = var.policy_effect == "auditIfNotExists" ? jsonencode({
    // If the policy effect is auditIfNotExists
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Storage/storageAccounts"
        },
        {
          field  = "Microsoft.Storage/storageAccounts/sku.name"
          equals = "Standard_RAGRS"
        },
        {
          not = {
            allOf = [
              {
                field  = "tags['Policy Exempt']"
                exists = "true"
              },
              {
                field  = "tags['Policy Exempt']"
                equals = "Disallow Standard_RAGRS Storage Account Type"
              }
            ]
          }
        }
      ]
    }
    then = {
      effect = "auditIfNotExists"
      details = {
        type = "Microsoft.Storage/storageAccounts"
        existenceCondition = {
          allOf = [
            {
              field  = "tags['Policy Exempt']"
              exists = "true"
            },
            {
              field  = "tags['Policy Exempt']"
              equals = "Disallow Standard_RAGRS Storage Account Type"
            }
          ]
        }
      }
    }
    }) : jsonencode({
    // If the policy effect is deny
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Storage/storageAccounts"
        },
        {
          field  = "Microsoft.Storage/storageAccounts/sku.name"
          equals = "Standard_RAGRS"
        },
        {
          not = {
            allOf = [
              {
                field  = "tags['Policy Exempt']"
                exists = "true"
              },
              {
                field  = "tags['Policy Exempt']"
                equals = "Disallow Standard_RAGRS Storage Account Type"
              }
            ]
          }
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
}
