# WAF Standard Module by 7Clouds

Thank you for riding with us! Feel free to download or reference this respository in your terraform projects and studies

This module is a part of our product SCA — An automated API and Serverless Infrastructure generator that can reduce your API development time by 40-60% and automate your deployments up to 90%! Check it out at <https://seventechnologies.cloud>

Please rank this repo 5 starts if you like our job!

## Usage

* This module is a simple WAFv2, composed by Web ACL with Regional Scope and Resource Association
* It's been configured with "allow" for "default action" and "none" for "override action"
* The variable "RULES" has been created for serving a dynamic rule block, so you may customize it. Example:

```hcl
  dynamic "rule" {
    for_each = toset(var.RULES)

    content {
      name     = rule.value.name
      priority = rule.value.priority
      override_action {
        none {}
      }
      statement {
        managed_rule_group_statement {
          name        = rule.value.managed_rule_group_statement_name
          vendor_name = rule.value.managed_rule_group_statement_vendor_name
        }
      }
      visibility_config {
        cloudwatch_metrics_enabled = false
        metric_name                = rule.value.metric_name
        sampled_requests_enabled   = false
      }
    }
  }
```

* For "aws_wafv2_web_acl_association", you need to reference an api gateway stage or load balancer arn in order to perform the association, otherwise the rules will not be attached to any resource and the association will not be created. That's the variable to place the value(s): WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST.

## Example

```hcl
module "waf_standard_module" {
  source = "../.."

  PROJECT_NAME = "test_project"
  WAF_WEB_ACL_SCOPE                     = "REGIONAL"
  WAF_SCOPE_CLOUDWATCH_METRICS          = true
  WAF_SCOPE_SAMPLED_REQUESTS            = false
  WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST = []
  RULES = [
    {
      name                                     = "AWSManagedRulesAmazonIpReputationList"
      managed_rule_group_statement_name        = "AWSManagedRulesAmazonIpReputationList"
      managed_rule_group_statement_vendor_name = "AWS"
      metric_name                              = "AWSManagedRulesAmazonIpReputationList"
      priority                                 = 2
    },
    {
      name                                     = "AWSManagedRulesSQLiRuleSet"
      managed_rule_group_statement_name        = "AWSManagedRulesSQLiRuleSet"
      managed_rule_group_statement_vendor_name = "AWS"
      metric_name                              = "AWSManagedRulesSQLiRuleSet"
      priority                                 = 3
    },
    {
      name                                     = "AWSManagedRulesAnonymousIpList"
      managed_rule_group_statement_name        = "AWSManagedRulesAnonymousIpList"
      managed_rule_group_statement_vendor_name = "AWS"
      metric_name                              = "AWSManagedRulesAnonymousIpList"
      priority                                 = 4
    }
  ]
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_waf_standard_module"></a> [waf\_standard\_module](#module\_waf\_standard\_module) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_wafv2_web_acl.waf_web_acl_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_association.waf_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_PROJECT_NAME"></a> [PROJECT\_NAME](#input\_PROJECT\_NAME) | The project name that will be prefixed to resource names | `string` | `""` | no |
| <a name="input_RULES"></a> [RULES](#input\_RULES) | Rule blocks used to identify the web requests that you want to allow, block, or count | `list(any)` | `[]` | no |
| <a name="input_WAF_SCOPE_CLOUDWATCH_METRICS"></a> [WAF\_SCOPE\_CLOUDWATCH\_METRICS](#input\_WAF\_SCOPE\_CLOUDWATCH\_METRICS) | Whether the associated resource sends metrics to CloudWatch | `bool` | n/a | yes |
| <a name="input_WAF_SCOPE_SAMPLED_REQUESTS"></a> [WAF\_SCOPE\_SAMPLED\_REQUESTS](#input\_WAF\_SCOPE\_SAMPLED\_REQUESTS) | Whether AWS WAF should store a sampling of the web requests that match the rules | `bool` | n/a | yes |
| <a name="input_WAF_WEB_ACL_SCOPE"></a> [WAF\_WEB\_ACL\_SCOPE](#input\_WAF\_WEB\_ACL\_SCOPE) | Specifies whether this is for an AWS CloudFront distribution or for a regional application | `string` | n/a | yes |
| <a name="input_WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST"></a> [WEB\_ACL\_ASSOCIATION\_RESOURCE\_ARN\_LIST](#input\_WEB\_ACL\_ASSOCIATION\_RESOURCE\_ARN\_LIST) | A list for the Amazon Resource Name (ARN) of the resources to associate with the web ACL. Must be ARN(S) of an Application Load Balancer or an Amazon API Gateway stage | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_PROJECT_NAME"></a> [PROJECT\_NAME](#output\_PROJECT\_NAME) | The project name that will be prefixed to resource names |
| <a name="output_RULES"></a> [RULES](#output\_RULES) | Rule blocks used to identify the web requests that you want to allow, block, or count |
| <a name="output_WAF_SCOPE_CLOUDWATCH_METRICS"></a> [WAF\_SCOPE\_CLOUDWATCH\_METRICS](#output\_WAF\_SCOPE\_CLOUDWATCH\_METRICS) | Whether the associated resource sends metrics to CloudWatch |
| <a name="output_WAF_SCOPE_SAMPLED_REQUESTS"></a> [WAF\_SCOPE\_SAMPLED\_REQUESTS](#output\_WAF\_SCOPE\_SAMPLED\_REQUESTS) | Whether AWS WAF should store a sampling of the web requests that match the rules |
| <a name="output_WAF_WEB_ACL_SCOPE"></a> [WAF\_WEB\_ACL\_SCOPE](#output\_WAF\_WEB\_ACL\_SCOPE) | Specifies whether this is for an AWS CloudFront distribution or for a regional application |
| <a name="output_WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST"></a> [WEB\_ACL\_ASSOCIATION\_RESOURCE\_ARN\_LIST](#output\_WEB\_ACL\_ASSOCIATION\_RESOURCE\_ARN\_LIST) | A list for the Amazon Resource Name (ARN) of the resources to associate with the web ACL. Must be ARN(S) of an Application Load Balancer or an Amazon API Gateway stage |
<!-- END_TF_DOCS -->