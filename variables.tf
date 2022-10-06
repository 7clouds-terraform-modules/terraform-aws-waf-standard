############################################################################################
#                                      ESSENTIAL                                           #
############################################################################################
variable "PROJECT_NAME" {
  type        = string
  description = "The project name that will be prefixed to resource names"
  default = ""
}

############################################################################################
#                                      STRUCTURAL                                          #
############################################################################################

variable "WAF_WEB_ACL_SCOPE" {
  type        = string
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application"
}

variable "WAF_SCOPE_CLOUDWATCH_METRICS" {
  type        = bool
  description = "Whether the associated resource sends metrics to CloudWatch"
}

variable "WAF_SCOPE_SAMPLED_REQUESTS" {
  type        = bool
  description = "Whether AWS WAF should store a sampling of the web requests that match the rules"
}

variable "RULES" {
  type        = list(any)
  description = "Rule blocks used to identify the web requests that you want to allow, block, or count"
  default     = []
}

variable "WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST" {
  type        = list(string)
  description = "A list for the Amazon Resource Name (ARN) of the resources to associate with the web ACL. Must be ARN(S) of an Application Load Balancer or an Amazon API Gateway stage"
  default     = []
}