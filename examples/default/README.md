# 7Clouds Terraform AWS WAF Standard Module

## Usage

* You may customize your list variable "RULES" according to your needs
* You need to provide an internet gateway or load balancer ARN for the list variable "WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST" in order to attach the rules to a resource, otherwise the attachment resource won't happen
* For furhter information regarding wafv2_web_acl, check [Terraforms Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) and [AWS Docs](https://docs.aws.amazon.com/waf/latest/APIReference/API_Operations_AWS_WAFV2.html)

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

* Visual Example for the RULES [dynamic block](https://www.terraform.io/language/expressions/dynamic-blocks) on main.tf:

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
