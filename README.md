terraform-azurerm-disallow-ragrs-policy
===============================================


This Terraform module creates an Azure policy definition that disallows the creation of storage accounts with the Standard_RAGRS sku type unless they have the appropriate exemption tag. The policy definition can be assigned to a management group or subscription. Current exemption tag is "Exempt: Disallow Standard_RAGRS".

https://rudycorradetti.com/2023/05/12/terraform-azurerm-disallow-ragrs-policy-a-terraform-module-to-prevent-or-audit-the-creation-of-standard_ragrs-storage-accounts/


Inputs
------

| Name                     | Description                                                                                                                | Type   | Default                                         | Required |
|--------------------------|----------------------------------------------------------------------------------------------------------------------------|--------|-------------------------------------------------|----------|
| policy_definition_name   | The name of the policy definition.                                                                                         | string | "Disallow Standard_RAGRS Storage Account Type"  | no       |
| policy_display_name      | The display name of the policy definition.                                                                                 | string | "Disallow Standard_RAGRS Storage Account Type"  | no       |
| policy_description       | The description of the policy definition.                                                                                  | string | "This policy definition denies the creation of Standard_RAGRS storage accounts unless they have the tag - Exempt: Disallow Standard_RAGRS" | no |
| management_group_id      | The ID of the management group where the policy definition should be created.                                             | string | "/providers/Microsoft.Management/managementGroups/Your_Management_Group_ID | yes |
| policy_exempt_tag        | The tag to be used for exemptions. If a storage account has this tag, it won't be audited by the policy.                   | string | "Exempt: Disallow Standard_RAGRS"               | no       |
| policy_effect            | The effect of the policy. Choose between 'auditIfNotExists' and 'deny'.                                                    | string | "auditIfNotExists"                              | no       |

Outputs
-------

There are no outputs for this module.

Usage
-----

```hcl
# Deploy policy definition in deny mode
module "disallow_ragrs_policy" {
  source  = "./terraform-azurerm-disallow-ragrs-policy"
  # version = "1.0.0"
  # policy effect - default is auditIfNotExists. Comment out the line below to use the default value.
  policy_effect = "deny"
  # management_group_id = "/providers/Microsoft.Management/managementGroups/Your_Management_Group_ID"
}

# Assign the policy to the management group
resource "azurerm_management_group_policy_assignment" "disallow_ra_grs_storage_assignment" {
  name               = "Deny Standard_RAGRS"
  management_group_id = "/providers/Microsoft.Management/managementGroups/Your_Management_Group_ID"
  # Acquired after deploying the policy definition
  policy_definition_id = "/providers/Microsoft.Management/managementGroups/Your_Management_Group_ID/providers/Microsoft.Authorization/policyDefinitions/Disallow Standard_RAGRS Storage Account Type"
}
