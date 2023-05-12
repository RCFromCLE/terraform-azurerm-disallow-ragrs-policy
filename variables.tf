variable "policy_definition_name" {
  description = "The name of the policy definition."
  default = "Disallow Standard_RAGRS Storage Account Type"
}
variable "policy_display_name" {
  description = "The display name of the policy definition."
  type = string
  default = "Disallow Standard_RAGRS Storage Account Type"
}
variable "policy_description" {
  type = string
  description = "The description of the policy definition."
  default = "This policy definition denies the creation of Standard_RAGRS storage accounts unless they have the tag - Exempt: Disallow Standard_RAGRS"
}
variable "management_group_id" {
  type = string
  description = "The ID of the management group where the policy definition should be created."
  default = "/providers/Microsoft.Management/managementGroups/YOUR_MANAGEMENT_GROUP_ID"
}
variable "policy_exempt_tag" {
  type = string
  description = "The tag to be used for exemptions. If a storage account has this tag, it won't be audited by the policy."
  default = "Exempt: Disallow Standard_RAGRS"
}
variable "policy_effect" {
  type = string
  description = "The effect of the policy. Choose between 'auditIfNotExists' and 'deny'."
  default = "auditIfNotExists"
}