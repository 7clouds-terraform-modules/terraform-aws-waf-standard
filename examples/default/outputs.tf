output "PROJECT_NAME" {
  value       = module.waf_standard_module.PROJECT_NAME
  description = "The project name that will be prefixed to resource names"
}

output "WAF_WEB_ACL_SCOPE" {
  value       = module.waf_standard_module.WAF_WEB_ACL_SCOPE
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application"
}

output "WAF_SCOPE_CLOUDWATCH_METRICS" {
  value       = module.waf_standard_module.WAF_SCOPE_CLOUDWATCH_METRICS
  description = "Whether the associated resource sends metrics to CloudWatch"
}

output "WAF_SCOPE_SAMPLED_REQUESTS" {
  value       = module.waf_standard_module.WAF_SCOPE_SAMPLED_REQUESTS
  description = "Whether AWS WAF should store a sampling of the web requests that match the rules"
}

output "RULES" {
  value       = module.waf_standard_module.RULES
  description = "Rule blocks used to identify the web requests that you want to allow, block, or count"
}

output "WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST" {
  value       = module.waf_standard_module.WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST
  description = "A list for the Amazon Resource Name (ARN) of the resources to associate with the web ACL. Must be ARN(S) of an Application Load Balancer or an Amazon API Gateway stage"
}