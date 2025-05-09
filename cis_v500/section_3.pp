locals {
  cis_v500_3_common_tags = merge(local.cis_v500_common_tags, {
    cis_section_id = "3"
  })
}

benchmark "cis_v500_3" {
  title         = "3 Logging"
  documentation = file("./cis_v500/docs/cis_v500_3.md")
  children = [
    control.cis_v500_3_1,
    control.cis_v500_3_2,
    control.cis_v500_3_3,
    control.cis_v500_3_4,
    control.cis_v500_3_5,
    control.cis_v500_3_6,
    control.cis_v500_3_7,
    control.cis_v500_3_8,
    control.cis_v500_3_9
  ]

  tags = merge(local.cis_v500_3_common_tags, {
    type = "Benchmark"
  })
}

control "cis_v500_3_1" {
  title         = "3.1 Ensure CloudTrail is enabled in all regions"
  description   = "AWS CloudTrail is a web service that records AWS API calls for your account and delivers log files to you. The recorded information includes the identity of the API caller, the time of the API call, the source IP address of the API caller, the request parameters, and the response elements returned by the AWS service. CloudTrail provides a history of AWS API calls for an account, including API calls made via the Management Console, SDKs, command line tools, and higher-level AWS services (such as CloudFormation)."
  query         = query.cloudtrail_multi_region_read_write_enabled
  documentation = file("./cis_v500/docs/cis_v500_3_1.md")

  tags = merge(local.cis_v500_3_common_tags, {
    cis_item_id = "3.1"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "AWS/CloudTrail"
  })
}

control "cis_v500_3_2" {
  title         = "3.2 Ensure CloudTrail log file validation is enabled"
  description   = "CloudTrail log file validation creates a digitally signed digest file containing a hash of each log that CloudTrail writes to S3. These digest files can be used to determine whether a log file was changed, deleted, or unchanged after CloudTrail delivered the log. It is recommended that file validation be enabled on all CloudTrails."
  query         = query.cloudtrail_trail_validation_enabled
  documentation = file("./cis_v500/docs/cis_v500_3_2.md")

  tags = merge(local.cis_v500_3_common_tags, {
    cis_item_id = "3.2"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "AWS/CloudTrail"
  })
}

control "cis_v500_3_3" {
  title         = "3.3 Ensure AWS Config is enabled in all regions"
  description   = "AWS Config is a web service that performs configuration management of supported AWS resources within your account and delivers log files to you. The recorded information includes the configuration item (AWS resource), relationships between configuration items (AWS resources), any configuration changes between resources. It is recommended AWS Config be enabled in all regions."
  query         = query.config_enabled_all_regions
  documentation = file("./cis_v500/docs/cis_v500_3_3.md")

  tags = merge(local.cis_v500_3_common_tags, {
    cis_item_id = "3.3"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "AWS/Config"
  })
}

control "cis_v500_3_4" {
  title         = "3.4 Ensure that server access logging is enabled on the CloudTrail S3 bucket"
  description   = "Server access logging generates a log that contains access records for each request made to your S3 bucket. An access log record contains details about the request, such as the request type, the resources specified in the request worked, and the time and date the request was processed. It is recommended that server access logging be enabled on the CloudTrail S3 bucket."
  query         = query.cloudtrail_s3_logging_enabled
  documentation = file("./cis_v500/docs/cis_v500_3_4.md")

  tags = merge(local.cis_v500_3_common_tags, {
    cis_item_id = "3.4"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "AWS/CloudTrail"
  })
}

control "cis_v500_3_5" {
  title         = "3.5 Ensure CloudTrail logs are encrypted at rest using KMS CMKs"
  description   = "AWS CloudTrail is a web service that records AWS API calls for an account and makes those logs available to users and resources in accordance with IAM policies. AWS Key Management Service (KMS) is a managed service that helps create and control the encryption keys used to encrypt account data, and uses Hardware Security Modules (HSMs) to protect the security of encryption keys. CloudTrail logs can be configured to leverage server side encryption (SSE) and KMS customer-created master keys (CMK) to further protect CloudTrail logs. It is recommended that CloudTrail be configured to use SSE-KMS."
  query         = query.cloudtrail_trail_logs_encrypted_with_kms_cmk
  documentation = file("./cis_v500/docs/cis_v500_3_5.md")

  tags = merge(local.cis_v500_3_common_tags, {
    cis_item_id = "3.5"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "AWS/CloudTrail"
  })
}

control "cis_v500_3_6" {
  title         = "3.6 Ensure rotation for customer-created symmetric CMKs is enabled"
  description   = "AWS Key Management Service (KMS) allows customers to rotate the backing key, which is key material stored within the KMS that is tied to the key ID of the customer- created customer master key (CMK). The backing key is used to perform cryptographic operations such as encryption and decryption. Automated key rotation currently retains all prior backing keys so that decryption of encrypted data can occur transparently. It is recommended that CMK key rotation be enabled for symmetric keys. Key rotation cannot be enabled for any asymmetric CMK."
  query         = query.kms_cmk_rotation_enabled
  documentation = file("./cis_v500/docs/cis_v500_3_6.md")

  tags = merge(local.cis_v500_3_common_tags, {
    cis_item_id = "3.6"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "AWS/CloudTrail"
  })
}

control "cis_v500_3_7" {
  title         = "3.7 Ensure VPC flow logging is enabled in all VPCs"
  description   = "VPC Flow Logs is a feature that enables you to capture information about the IP traffic going to and from network interfaces in your VPC. After you've created a flow log, you can view and retrieve its data in Amazon CloudWatch Logs. It is recommended that VPC Flow Logs be enabled for packet `Rejects` for VPCs."
  query         = query.vpc_flow_logs_enabled
  documentation = file("./cis_v500/docs/cis_v500_3_7.md")

  tags = merge(local.cis_v500_3_common_tags, {
    cis_item_id = "3.7"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "AWS/VPC"
  })
}

control "cis_v500_3_8" {
  title         = "3.8 Ensure that Object-level logging for write events is enabled for S3 buckets"
  description   = "S3 object-level API operations, such as GetObject, DeleteObject, and PutObject, are referred to as data events. By default, CloudTrail trails do not log data events, so it is recommended to enable object-level logging for S3 buckets."
  query         = query.cloudtrail_s3_object_write_events_audit_enabled
  documentation = file("./cis_v500/docs/cis_v500_3_8.md")

  tags = merge(local.cis_v500_3_common_tags, {
    cis_item_id = "3.8"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "AWS/S3"
  })
}

control "cis_v500_3_9" {
  title         = "3.9 Ensure that Object-level logging for read events is enabled for S3 buckets"
  description   = "S3 object-level API operations, such as GetObject, DeleteObject, and PutObject, are referred to as data events. By default, CloudTrail trails do not log data events, so it is recommended to enable object-level logging for S3 buckets."
  query         = query.cloudtrail_s3_object_read_events_audit_enabled
  documentation = file("./cis_v500/docs/cis_v500_3_9.md")

  tags = merge(local.cis_v500_3_common_tags, {
    cis_item_id = "3.9"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "AWS/S3"
  })
}
