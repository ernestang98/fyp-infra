output "ec2_global_ips" {
  value = [{
  	"model_server": "${aws_instance.fyp-model-server.*.public_ip}",
  	"defect_dojo_server": "${aws_instance.defect-dojo-server.*.public_ip}",
  	"threat-dragon-server": "${aws_instance.threat-dragon-server.*.public_ip}"
  }]
}

output "private_key" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}

output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}

output "region" {
  description = "Region"
  value       = var.REGION
}

output "s3_bucket" {
  description = "Bucket for Thanos Object Store"
  value       = local.s3bucket
}

output "reports_bucket" {
  description = "Bucket to upload testing reports to"
  value       = local.reportsbucket
}
