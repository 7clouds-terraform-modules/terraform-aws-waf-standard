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
      priority                                 = 1
    },
    {
      name                                     = "AWSManagedRulesSQLiRuleSet"
      managed_rule_group_statement_name        = "AWSManagedRulesSQLiRuleSet"
      managed_rule_group_statement_vendor_name = "AWS"
      metric_name                              = "AWSManagedRulesSQLiRuleSet"
      priority                                 = 2
    },
    {
      name                                     = "AWSManagedRulesAnonymousIpList"
      managed_rule_group_statement_name        = "AWSManagedRulesAnonymousIpList"
      managed_rule_group_statement_vendor_name = "AWS"
      metric_name                              = "AWSManagedRulesAnonymousIpList"
      priority                                 = 3
    }
  ]
}