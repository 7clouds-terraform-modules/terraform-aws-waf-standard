resource "aws_wafv2_web_acl" "waf_web_acl_rules" {
  name        = "${var.PROJECT_NAME}WafWebAclRules"
  description = "WAF WEB ACL for API Gateway"
  scope       = var.WAF_WEB_ACL_SCOPE
  default_action {
    allow {}
  }
  visibility_config {
    cloudwatch_metrics_enabled = var.WAF_SCOPE_CLOUDWATCH_METRICS
    metric_name                = "${var.PROJECT_NAME}WafWebAclRules"
    sampled_requests_enabled   = var.WAF_SCOPE_SAMPLED_REQUESTS
  }

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
}


resource "aws_wafv2_web_acl_association" "waf_association" {
  count        = length(var.WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST) > 0 ? length(var.WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST) : 0
  resource_arn = element(var.WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST, count.index)
  web_acl_arn  = aws_wafv2_web_acl.waf_web_acl_rules.arn
}